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

class Firm < ActiveRecord::Base

  validates :name, :contact_name, :contact_email, :contact_phone, 
            :address_line_1, :city, :state, :zip, presence: true
  validates :contact_email, :email => true
  #TODO - validations on address components
  
  def contact_phone=(contact_phone)
    write_attribute(:contact_phone, contact_phone.gsub(/\D/, ''))
  end
  
  def contact_phone
    num   = read_attribute(:contact_phone)
    group = num.match(/(\d{3}?)(\d{3})(\d{4})/)
    group[1] == "" ? "#{group[2]}-#{group[3]}" : "(#{group[1]}) #{group[2]}-#{group[3]}"
  end
  
  def one_line_address
    line_1 = address_line_1
    line_2 = address_line_2
    
    "#{line_1} #{line_2 if line_2} #{city}, #{state} #{zip}"
  end
end
