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

class Customer < Firm
  has_many  :projects
  
  validates :name, :contact_name, :contact_email, :contact_phone, presence: true
  validates :contact_email, :email => true
  #TODO - validations on address components
  
  def one_line_address
    
  end
end
