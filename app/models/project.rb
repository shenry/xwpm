# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  package_id     :integer
#  wine_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  customer_id    :integer
#  qb_code        :string
#  project_number :string
#  target_cases   :integer
#  name           :string           default(""), not null
#  description    :string           default(""), not null
#

class Project < ActiveRecord::Base
  include ProjectsHelper
  include CostHelper

  # belongs_to  :closure, polymorphic: true
  # belongs_to  :capsule
  # belongs_to  :bottle
  # belongs_to  :back_label
  # belongs_to  :front_label
  belongs_to  :wine, inverse_of: :projects
  belongs_to  :customer, class_name: "Firm", counter_cache: true
  
  has_many    :components, class_name: "ComponentRequirement"
  has_one     :bottle_requirement, -> { where(packageable_type: "Bottle") }, class_name: "ComponentRequirement"
  has_one     :bottle, through: :bottle_requirement, source: :packageable, source_type: "Bottle"
  
  has_one     :capsule_requirement, -> { where(packageable_type: "Capsule") }, class_name: "ComponentRequirement"
  has_one     :capsule, through: :capsule_requirement, source: :packageable, source_type: "Capsule"
  
  has_one     :closure_requirement, -> { where(packageable_type: "Closure") }, class_name: "ComponentRequirement"
  has_one     :closure, through: :closure_requirement, source: :packageable, source_type: "Closure"
  
  has_one     :front_label_requirement, -> { where(packageable_type: "FrontLabel") }, class_name: "ComponentRequirement"
  has_one     :front_label, through: :front_label_requirement, source: :packageable, source_type: "BackLabel"
  
  has_one     :back_label_requirement, -> { where(packageable_type: "BackLabel") }, class_name: "ComponentRequirement"
  has_one     :back_label, through: :back_label_requirement, source: :packageable, source_type: "BackLabel"
  

  
  has_many    :comments, inverse_of: :project, dependent: :destroy
  has_many    :packaging_component_orders, inverse_of: :project, dependent: :destroy
  has_many    :purchase_orders, through: :packaging_component_orders
  has_many    :events, class_name: "ProjectEvent", inverse_of: :project, dependent: :destroy
  
  before_create :set_initial_state
  # before_save   :format_project_number, :set_closure_type, :set_capsule_status
  
  validates :project_number, :brand, :variety, :target_cases, :bottling_date, 
            :vintage, :appellation, presence: true
  validates :project_number, format: { with: /\A\d{2}\-?\d{2}\w?\z/ }
  validates :target_cases, numericality: { only_integer: true }
  validate  :bottling_date_cant_be_in_the_past

  scope     :active,  -> { where("bottling_date >= ?", Date.today) }
  
  STATES = %w(in_development live bottled qb_entered costed cancelled)
  delegate :in_development?, :live?, :bottled?, :qb_entered?, :costed?, :cancelled?, to: :current_state
  
  def self.associated_with_vendor(id)
    components  = PackagingComponent.where("vendor_id = ?", id) #TODO - reference only "active" components
    array       = components.map { |c| c.id }
    str         = array.join(",")
    joins("INNER JOIN packaging_components ON projects.bottle_id IN (#{str})
    OR projects.capsule_id IN (#{str}) OR projects.closure_id IN (#{str}) 
    OR projects.front_label_id IN (#{str}) OR projects.back_label_id IN (#{str}) 
    GROUP BY projects.id")
  end
  
  STATES.each do |state|    
    define_singleton_method("#{state}") do
      joins(:events).merge ProjectEvent.with_last_state(state)
    end
    
    define_method("#{state}!") do
      new_event = self.events.build(state: state)
      new_event.save
    end
  end
  
  def current_state
    (events.last.try(:state) || STATES.first).inquiry
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
    
  def formatted_bottling_date
    bottling_date.strftime(BOTTLING_DATE_FORMAT_STRING)
  end
  
  def to_s
    "[#{project_number}] - #{vintage} #{brand} #{variety}"
  end
  
  def label_alc
    return "TBD" if front_label.nil?
    front_label.label_alc
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
  
  def set_initial_state
    in_development!
  end
  
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
