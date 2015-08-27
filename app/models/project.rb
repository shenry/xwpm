# == Schema Information
#
# Table name: projects
#
#  id                :integer          not null, primary key
#  wine_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  customer_id       :integer
#  qb_code           :string
#  project_number    :string
#  target_cases      :integer
#  brand             :string           default(""), not null
#  description       :string           default(""), not null
#  bottling_date     :datetime
#  variety           :string
#  winemaker         :string
#  no_capsule        :boolean          default(FALSE), not null
#  vintage           :string
#  appellation       :string
#  closure_type      :string
#  trucker           :string
#  cases_to_customer :integer          default(0), not null
#  comments_count    :integer
#  fob               :float
#  taxes             :string
#  fso2_target       :string
#  max_do            :string
#  notes             :text             default("")
#

class Project < ActiveRecord::Base
  include ProjectsHelper
  include CostHelper
  include PgSearch
  include AASM

  belongs_to  :wine, inverse_of: :projects
  belongs_to  :customer, class_name: "Firm", counter_cache: true
  belongs_to  :bottler, class_name: "Firm"
  belongs_to  :produced_at, class_name: "Firm"
  belongs_to  :bottled_at, class_name: "Firm"
  
  has_many    :components, class_name: "ComponentRequirement"
  has_many    :component_orders, through: :components, class_name: "PackagingComponentOrder"
  has_many    :purchase_orders, through: :component_orders
  
  has_many    :bottle_requirements, -> { where(packageable_type: "Bottle").order("created_at ASC") }, class_name: "ComponentRequirement"
  has_many    :bottles, through: :bottle_requirements, source: :packageable, source_type: "Bottle"
  
  has_many    :capsule_requirements, -> { where(packageable_type: "Capsule").order("created_at ASC") }, class_name: "ComponentRequirement"
  has_many    :capsules, through: :capsule_requirements, source: :packageable, source_type: "Capsule"
  
  has_many    :closure_requirements, -> { where(packageable_type: "Closure").order("created_at ASC") }, class_name: "ComponentRequirement"
  has_many    :closures, through: :closure_requirements, source: :packageable, source_type: "Closure"
  
  has_many    :front_label_requirements, -> { where(packageable_type: "FrontLabel").order("created_at ASC") }, class_name: "ComponentRequirement"
  has_many    :front_labels, through: :front_label_requirements, source: :packageable, source_type: "FrontLabel"
  
  has_many    :back_label_requirements, -> { where(packageable_type: "BackLabel").order("created_at ASC") }, class_name: "ComponentRequirement"
  has_many    :back_labels, through: :back_label_requirements, source: :packageable, source_type: "BackLabel"
  
  accepts_nested_attributes_for :components
  accepts_nested_attributes_for :bottle_requirements, :capsule_requirements, :closure_requirements,
                                :front_label_requirements, :back_label_requirements, allow_destroy: true
  
  has_many    :comments, inverse_of: :project, dependent: :destroy
  # has_many    :packaging_component_orders, inverse_of: :project
  # has_many    :purchase_orders, through: :packaging_component_orders, inverse_of: :projects
  
  # before_create :set_initial_state
  before_save   :format_project_number
  
  validates :project_number, :brand, :variety, :target_cases, :bottling_date, 
            :vintage, :appellation, presence: true
  validates :project_number, format: { with: /\A\d{2}\-?\d{2}\w?\z/ }
  validates :project_number, uniqueness: true
  validates :target_cases, numericality: { only_integer: true }
  validate  :bottling_date_cant_be_in_the_past, on: :create

  scope     :planned,  -> { where("bottling_date >= ?", 1.week.ago).order("bottling_date ASC").not_cancelled }
  scope     :not_cancelled, -> { where.not(aasm_state: [:cancelled, :closed]) }
  scope     :for_customer, ->(id) { where("customer_id = ?", id) }
  
  # multisearchable against: [:brand, :variety, :appellation, :vintage, :notes]
  pg_search_scope :search_all, against: [:brand, :variety, :appellation, :project_number], 
                  using: { tsearch: { dictionary: 'english' }, trigram: { threshold: 0.2 } }
                  
  aasm do
    state :cancelled
    state :in_development, intial: true
    state :active
    state :ready
    state :bottled
    state :costed
    state :closed
    
    event :activate do
      transitions from: [:in_development, :cancelled], to: :active
    end
    
    event :deactivate do
      transitions from: [:active, :ready], to: :in_development
    end
    
    event :make_ready do
      transitions from: :active, to: :ready, if: :ready_for_bottling?
    end
    
    event :cancel do
      transitions from: [:in_development, :active, :ready], to: :cancelled
    end
    
    event :un_cancel do
      transitions from: :cancelled, to: :in_development
    end
    
    event :bottle do
      transitions from: :ready, to: :bottled
    end
    
    event :cost do
      transitions from: :bottled, to: :costed, if: :can_apply_costs?
    end
    
    event :close do
      transitions from: :costed, to: :closed
    end
  end
  
  scope :ready, -> { where(aasm_state: ['in_development', 'active', 'ready']) }
  
  def self.fetch_filtered(params_hash)
    customer_id = params_hash[:customer_id]
    vendor_id   = params_hash[:vendor_id]
    scope       = params_hash[:scope] || :planned
    return Project.send(scope) unless (customer_id || vendor_id)
    return Customer.find(customer_id).projects.active if customer_id
    return Project.associated_with_vendor(vendor_id).active if vendor_id
  end
  
  def self.text_search(query)
    if query.present?
      search_all(query)
    else
      all
    end
  end
  
  def self.scoped
    all
  end
  
  def events_map
    aasm.events(permitted: true).each_with_object({}) { |v, h| h[v.transitions.map(&:to).uniq[0]] = v.name }
  end
  
  def available_components_for(category)
    klass = category.split("_").each { |s| s.capitalize! }.join("").constantize
    components = klass.active
    assigned_components = self.send(category.pluralize.intern)
    available = components - assigned_components
    klass.select_options(available)
  end
  
  def packageable_units
    target_cases * bottles.first.bottles_per_case.to_i
  end
  
  def self.associated_with_vendor(vendor_id)
    attr_hash = Vendor.find(vendor_id).products_attr_hash
    joins(:components).where(:component_requirements => { :packageable_type => attr_hash[:types], :packageable_id => attr_hash[:ids]}).group("projects.id")
  end
  
  def purchase_orders
    ids = components.map(&:id)
    return [] if ids.empty?
    PurchaseOrder.joins("INNER JOIN packaging_component_orders ON 
    purchase_orders.id = packaging_component_orders.purchase_order_id WHERE 
    packaging_component_orders.component_requirement_id IN (#{ids.join(',')}) GROUP BY purchase_orders.id")
  end
  
  def components_for_select(vendor_id)
    components.inject({options: [], disabled: []}) do |hash, component|
      hash[:options] << [component.packageable.to_s, component.id]
      if (component.packageable.vendor.id != vendor_id.to_i || PackagingComponentOrder.find_by_component_requirement_id(component.id))
        hash[:disabled] << component.id
      end
      hash
    end
  end
  
  def customer_name
    customer.name
  end
  
  def cases_to_warehouse
    target_cases - cases_to_customer
  end
  
  def actionable_comments
    comments.where(actionable: true)
  end
  
  def materials
    arr = [self.front_label, self.back_label, self.capsule, self.bottle, self.closure]
    arr.compact
  end
  
  def to_s
    "[#{project_number}] - #{vintage} #{brand} #{variety}"
  end
  
  def label_alc
    return "TBD" if front_labels.empty?
    front_labels.first.alc
  end
  
  def front_label_position
    formatted_label_position(:front_label)
  end
  
  def back_label_position
    formatted_label_position(:back_label)
  end
  
  def label_info_for_type(type)
    return "N/A" if self.send(type).nil?
    self.send(type).material + " - " + self.send(type).specs
  end
  
  def missing(assoc)
    "<em>No #{assoc.to_s.titleize} Present</em>".html_safe
  end
  
  def aasm_state_names
    aasm.states.map(&:name)
  end
  
  def permitted_aasm_state_names
    aasm.states(permitted: true).map(&:name)
  end
  
  private
  
  def can_apply_costs?
    true
  end
  
  REQUIRED_COMPONENTS = ["Bottle", "Closure", "Front Label"]
  
  def ready_for_bottling?
    r = has_required_components?
    v = has_valid_components?
    q = has_valid_component_quantities?
    r && v && q
  end
  
  def has_valid_components?
    true
  end
  
  def has_valid_component_quantities?
    self.components.each do |c|
      return false unless c.packageable.usable_inventory >= c.packageable.quantity
    end
    true
  end
  
  def has_required_components?
    REQUIRED_COMPONENTS.each do |c|
      return false unless components_list.include? c
    end
    true
  end
  
  def components_list
    self.components.collect(&:packageable_type).compact
  end
  
  def format_project_number
    unless project_number.match(/\A\d{2}\-\d{2}\w?\z/)
      match = project_number.match(/\A(\d{2})\-?(\d{2})(\w?)\z/)
      str   = "#{match[1]}-#{match[2]}#{match[3].upcase}"
      self.project_number = str
    end
  end
  
  def bottling_date_cant_be_in_the_past
    errors.add(:bottling_date, "can't be in the past") if !bottling_date.blank? && bottling_date < Date.today
  end
  
end
