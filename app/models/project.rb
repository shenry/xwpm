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
  # belongs_to  :package
  belongs_to  :closure, polymorphic: true
  belongs_to  :capsule
  belongs_to  :bottle
  belongs_to  :shipper
  belongs_to  :back_label
  belongs_to  :front_label
  belongs_to  :wine
  belongs_to  :customer, class_name: "Firm", counter_cache: true
  
  has_many    :comments, dependent: :destroy
  
  before_save :format_project_number, :set_closure_type
  
  validates :project_number, :brand, :variety, :target_cases, :bottling_date, presence: true
  validates :project_number, format: { with: /\A\d{2}\-?\d{2}\w?\z/ }
  validates :target_cases, numericality: { only_integer: true }
  validate  :bottling_date_cant_be_in_the_past

  scope     :active, -> { where("bottling_date >= ?", Date.today) }
  
  def cases_to_warehouse
    target_cases - cases_to_customer
  end
  
  def actionable_comments
    comments.where(actionable: true)
  end
  
  def materials
    puts "closure is #{self.closure}"
    arr = [self.bottle, self.closure, self.capsule, self.front_label, self.back_label, self.shipper]
    arr.compact!
  end
    
  def formatted_bottling_date
    bottling_date.strftime(BOTTLING_DATE_FORMAT_STRING)
  end
  
  def to_s
    "#{vintage} #{brand} #{variety}"
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
  
  private
  
  def set_closure_type
    unless closure_id == nil
      self.closure_type = "PackagingComponent"
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
