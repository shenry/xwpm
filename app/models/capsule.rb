class Capsule < ActiveRecord::Base
  include PackagingComponent
  
  has_many  :component_requirements, as: :packageable
  has_many  :projects, through: :component_requirements
  has_one   :vendor_product, as: :vendable, dependent: :destroy
  has_one   :vendor, through: :vendor_product
  
  mount_uploader :artwork, ImageUploader
  
  def specs
    "#{height} x #{diameter} #{units}"
  end
end