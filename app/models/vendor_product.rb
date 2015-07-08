class VendorProduct < ActiveRecord::Base
  belongs_to :vendor
  belongs_to :vendable, polymorphic: true
end