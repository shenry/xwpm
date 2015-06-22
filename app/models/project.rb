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
  # belongs_to  :package
  belongs_to  :closure
  belongs_to  :capsule
  belongs_to  :bottle
  belongs_to  :shipper
  belongs_to  :back_label
  belongs_to  :front_label
  belongs_to  :wine
  belongs_to  :customer, class_name: "Firm", counter_cache: true
  
  before_save :format_project_number
  
  validates :project_number, :brand, :variety, :target_cases, :bottling_date, presence: true
  validates :project_number, format: { with: /\A\d{2}\-?\d{2}\w?\z/ }
  validate  :bottling_date_cant_be_in_the_past

  scope     :active, -> { where("bottling_date >= ?", Date.today) }
  
  def formatted_bottling_date
    bottling_date.strftime("%m/%d/%y")
  end
  
  def to_s
    "#{vintage} #{brand} #{variety}"
  end
  
  def label_alc
    return "TBD" if front_label.nil?
    front_label.label_alc
  end
  
  private
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
