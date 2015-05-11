class Project < ActiveRecord::Base
  belongs_to  :package
  belongs_to  :wine
  belongs_to  :customer, class_name: "Firm"
  # belongs_to  :bottler
  # belongs_to  :bottling_facility
end
