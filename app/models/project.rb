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
  belongs_to  :package
  belongs_to  :wine
  belongs_to  :customer, class_name: "Firm", counter_cache: true
  
  accepts_nested_attributes_for :wine, allow_destroy: false
end
