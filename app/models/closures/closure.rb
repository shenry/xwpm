class Closure < ActiveRecord::Base
  has_many    :packages
  belongs_to  :vendor, class_name: "Firm"
end