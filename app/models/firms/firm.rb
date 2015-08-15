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

class Firm < ActiveRecord::Base

  validates :name, :contact_name, :contact_email, :contact_phone, 
            :address_line_1, :city, :state, :zip, presence: true
  validates :contact_email, :email => true
  validates :zip, numericality: { only_integer: true }
  validates :contact_phone, format: { with: /\A\(?\d{3}\)?(\s?|-?)\d{3}(\s?|-?)\d{4}\z/,
                                      message: "Valid formats are (555) 123-4567 or simply 5551234567"}
  #TODO - validations on address components
  
  before_save :format_phone_number
  
  def one_line_address
    line_1 = address_line_1
    line_2 = address_line_2
    
    "#{line_1}, #{line_2 if line_2} #{city}, #{state.upcase} #{zip}"
  end
  
  def to_s
    name
  end
  
  private
  
  def format_phone_number
    num = contact_phone.gsub(/\D/, '')
    group = num.match(/(\d{3}?)(\d{3})(\d{4})/)
    self.contact_phone = (group[1] == "") ? "#{group[2]}-#{group[3]}" : "(#{group[1]}) #{group[2]}-#{group[3]}"
  end
end
