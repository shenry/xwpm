class Capsule < ActiveRecord::Base
  has_many  :component_requirements, as: :packageable
  has_one   :vendor_product, as: :vendable
  has_one   :vendor, through: :vendor_product
end