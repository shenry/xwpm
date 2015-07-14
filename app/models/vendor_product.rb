# == Schema Information
#
# Table name: vendor_products
#
#  id            :integer          not null, primary key
#  vendable_id   :integer
#  vendable_type :string
#  vendor_id     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class VendorProduct < ActiveRecord::Base
  belongs_to :vendor
  belongs_to :vendable, polymorphic: true
end
