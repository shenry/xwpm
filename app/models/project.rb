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
#

class Project < ActiveRecord::Base
  include ProjectsHelper
  include CostHelper

  belongs_to  :wine, inverse_of: :projects
  belongs_to  :customer, class_name: "Firm", counter_cache: true
  
  has_many    :components, class_name: "ComponentRequirement"
  has_many    :component_orders, through: :components, class_name: "PackagingComponentOrder"
  has_many    :purchase_orders, through: :component_orders
  
  has_one     :bottle_requirement, -> { where(packageable_type: "Bottle") }, class_name: "ComponentRequirement"
  has_one     :bottle, through: :bottle_requirement, source: :packageable, source_type: "Bottle"
  
  has_one     :capsule_requirement, -> { where(packageable_type: "Capsule") }, class_name: "ComponentRequirement"
  has_one     :capsule, through: :capsule_requirement, source: :packageable, source_type: "Capsule"
  
  has_one     :closure_requirement, -> { where(packageable_type: "Closure") }, class_name: "ComponentRequirement"
  has_one     :closure, through: :closure_requirement, source: :packageable, source_type: "Closure"
  
  has_one     :front_label_requirement, -> { where(packageable_type: "FrontLabel") }, class_name: "ComponentRequirement"
  has_one     :front_label, through: :front_label_requirement, source: :packageable, source_type: "FrontLabel"
  
  has_one     :back_label_requirement, -> { where(packageable_type: "BackLabel") }, class_name: "ComponentRequirement"
  has_one     :back_label, through: :back_label_requirement, source: :packageable, source_type: "BackLabel"
  
  accepts_nested_attributes_for :components
  accepts_nested_attributes_for :bottle_requirement, :capsule_requirement, :closure_requirement,
                                :front_label_requirement, :back_label_requirement, allow_destroy: true
  
  has_many    :comments, inverse_of: :project, dependent: :destroy
  has_many    :packaging_component_orders, inverse_of: :project, dependent: :destroy
  has_many    :purchase_orders, through: :packaging_component_orders, inverse_of: :projects
  
  # before_create :set_initial_state
  before_save   :format_project_number
  
  validates :project_number, :brand, :variety, :target_cases, :bottling_date, 
            :vintage, :appellation, presence: true
  validates :project_number, format: { with: /\A\d{2}\-?\d{2}\w?\z/ }
  validates :target_cases, numericality: { only_integer: true }
  validate  :bottling_date_cant_be_in_the_past

  scope     :active,  -> { where("bottling_date >= ?", Date.today) }
  
  def self.associated_with_vendor(vendor_id)
    attr_hash = Vendor.find(vendor_id).products_attr_hash
    joins(:components).where(:component_requirements => { :packageable_type => attr_hash[:types], :packageable_id => attr_hash[:ids]}).group("projects.id")
  end
  
  def purchase_orders
    ids = components.map(&:id)
    PurchaseOrder.joins("INNER JOIN 'packaging_component_orders' ON 
    'purchase_orders'.'id' = 'packaging_component_orders'.'purchase_order_id' WHERE 
    'packaging_component_orders'.'component_requirement_id' IN (#{ids.join(',')}) GROUP BY 'purchase_orders'.'id'")
  end
  
  def components_for_select(vendor_id)
    components.inject({options: [], disabled: []}) do |hash, component|
      hash[:options] << [component.packageable.to_s, component.id]
      unless component.packageable.vendor.id == vendor_id.to_i
        puts "they don't match!"
        hash[:disabled] << component.id
      end
      hash
    end
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
    return "TBD" if front_label.nil?
    front_label.alc
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
  
  private
  
  # def set_initial_state
  #   in_development!
  # end
  
  # def dateify_bottling_date
  #   unless bottling_date.blank?
  #     self.bottling_date = Date.strptime(bottling_date, BOTTLING_DATE_FORMAT_STRING)
  #   end
  # end
  
  def set_closure_type
    unless closure_id == nil
      self.closure_type = "PackagingComponent"
    end
  end
  
  def set_capsule_status
    if closure.is_a?  Screwcap
      self.no_capsule = true
      self.capsule_id = nil
    end
  end
  
  def formatted_label_position(type)
    return "N/A" if self.send(type).nil?
    self.send(type).label_position + "mm"
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
