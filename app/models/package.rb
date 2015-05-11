class Package < ActiveRecord::Base
  has_many    :projects
  belongs_to  :closure
  belongs_to  :front_label, class_name: "Label"
  belongs_to  :back_label,  class_name: "Label"
  belongs_to  :capsule
  belongs_to  :bottle
  belongs_to  :shipper
end
