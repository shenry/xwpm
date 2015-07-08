class Bottle < ActiveRecord::Base
  include PackagingComponent
  has_one   :vendor_product, as: :vendable
  has_one   :vendor, through: :vendor_product

  has_many :component_requirements, as: :packageable
  
  def case_config
    "#{bottles_per_case} x #{capacity} #{units}"
  end
end