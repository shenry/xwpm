# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string
#  package_id  :integer
#  wine_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer
#

class Project < ActiveRecord::Base
  belongs_to  :package
  belongs_to  :wine
  belongs_to  :customer, class_name: "Firm"
  # belongs_to  :bottler
  # belongs_to  :bottling_facility
end
