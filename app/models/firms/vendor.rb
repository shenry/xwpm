class Vendor < Firm
  has_many  :closures
  has_many  :labels
  has_many  :bottles
  has_many  :capsules
  has_many  :shippers
end