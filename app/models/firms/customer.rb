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

class Customer < Firm
  has_many  :projects, dependent: :destroy
  has_many  :wine_shipments, -> { order("ship_date DESC") }, dependent: :destroy
  has_many  :sampled_wines, through: :wine_shipments, source: :wine
  
  accepts_nested_attributes_for :projects, allow_destroy: true
  
  class << self
    def primary_association
      :projects
    end
    
    def select_options
      grp = Customer.order(:name)
      out = []
      grp.each do |c|
        out << [c.name, c.id]
      end
      out
    end
    
  end  
  def unreviewed_wine_shipments
    wine_shipments.select { |s| s.accepted == false || s.feedback.blank? }
  end
end
