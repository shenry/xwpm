class BackLabel < Label
  has_one   :vendor_product, as: :vendable
  has_one   :vendor, through: :vendor_product
end