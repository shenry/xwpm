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
  has_many :products, class_name: "VendorProduct", dependent: :destroy
  has_many :purchase_orders, inverse_of: :vendor , dependent: :destroy
  
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
