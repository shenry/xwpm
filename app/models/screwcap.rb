class Screwcap < Closure
  has_one   :vendor_product, as: :vendable
  has_one   :vendor, through: :vendor_product
  
  scope :active, -> { where(active: true) }
  
end