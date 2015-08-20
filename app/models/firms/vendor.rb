# == Schema Information
#
# Table name: firms
#
#  id             :integer          not null, primary key
#  type           :string
#  name           :string           default(""), not null
#  description    :string           default(""), not null
#  contact_name   :string
#  contact_email  :string
#  contact_phone  :string
#  address_line_1 :string
#  address_line_2 :string
#  city           :string
#  state          :string
#  zip            :string
#  bond           :string
#  account_number :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  projects_count :integer
#  code           :string
#

class Vendor < Firm
  # has_many :products, class_name: "VendorProduct", dependent: :destroy
  has_many :vendor_products, dependent: :destroy
  has_many :bottles, through: :vendor_products, source: :vendable, source_type: "Bottle"
  has_many :capsules, through: :vendor_products, source: :vendable, source_type: "Capsule"
  has_many :closures, through: :vendor_products, source: :vendable, source_type: "Closure"
  has_many :front_labels, through: :vendor_products, source: :vendable, source_type: "FrontLabel"
  has_many :back_labels, through: :vendor_products, source: :vendable, source_type: "BackLabel"
    
  has_many :purchase_orders, inverse_of: :vendor , dependent: :destroy
  
  def products
    bottles + capsules + closures + front_labels + back_labels
  end
  
  def product_types
    vendor_products.collect { |p| p.vendable_type }.uniq
  end
  
  def products_select
    collection = []
    product_types.each do |type|
      collection << [type, self.send(type.underscore.downcase.pluralize).map { |p| [p.to_s, p.to_sgid]}]
    end
    collection
  end
  
  def self.primary_association
    :products
  end
  
  def products_attr_hash
    products.inject({ids: [], types: []}) do |hash, vp|
      hash[:ids] << vp.vendable_id
      hash[:types] << vp.vendable_type
      hash
    end
  end

end
