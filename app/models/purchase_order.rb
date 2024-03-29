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
#  order_date       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  line_items_count :integer
#  overhead         :float            default(0.0)
#

class PurchaseOrder < ActiveRecord::Base
  belongs_to  :vendor, inverse_of: :purchase_orders
  has_many    :line_items, -> { order("id ASC") }, dependent: :destroy, 
              class_name: "PackagingComponentOrder"
  has_many    :component_requirements, through: :line_items
  has_many    :projects, through: :component_requirements
              
  mount_uploader :po_image,   ImageUploader
  mount_uploader :bol_image,  ImageUploader
      
  accepts_nested_attributes_for :line_items
  
  def to_s
    "PO##{number} - #{vendor.name} "
  end
  
  def open?
    !closed?
  end
  
  def closed?
    all_line_items_received?
  end
  
  def all_line_items_received?
    line_items.map(&:aasm_state).all? { |state| state == "received" }
  end
  
  def subtotal
    line_items.sum(:price)
  end
  
  def total
    overhead + subtotal
  end
end
