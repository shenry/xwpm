# == Schema Information
#
# Table name: purchase_orders
#
#  id               :integer          not null, primary key
#  vendor_id        :integer
#  number           :string           default(""), not null
#  po_image         :string
#  bol_image        :string
#  total            :float
#  receive_date     :datetime
#  order_date       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  line_items_count :integer
#

class PurchaseOrder < ActiveRecord::Base
  belongs_to  :vendor, inverse_of: :purchase_orders
  has_many    :line_items, dependent: :destroy, 
              class_name: "PackagingComponentOrder", foreign_key: :purchase_order_id
              
  mount_uploader :po_image,   ImageUploader
  mount_uploader :bol_image,  ImageUploader
      
  accepts_nested_attributes_for :line_items
  
  scope :open, -> { where(receive_date: nil) }
  
  def to_s
    "PO##{number} - #{vendor.name} "
  end
end
