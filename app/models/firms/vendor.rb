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
#

class Vendor < Firm
  # has_many :packaging_components, inverse_of: :vendor, dependent: :destroy
  has_many :products, class_name: "VendorProduct", dependent: :destroy
  has_many :bottles, through: :products, source: :vendable, source_type: "Bottle"
  
  has_many :purchase_orders, inverse_of: :vendor , dependent: :destroy
  
  validates :code, presence: true
  
  before_save :upcase_code
  
  private
  def upcase_code
    self.code = self.code.upcase
  end

end
