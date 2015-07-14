# == Schema Information
#
# Table name: wine_shipments
#
#  id              :integer          not null, primary key
#  customer_id     :integer
#  wine_id         :integer
#  tracking_number :string
#  ship_date       :datetime
#  feedback        :string
#  carrier         :string
#  approved        :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class WineShipment < ActiveRecord::Base
  belongs_to :customer, class_name: "Firm"
  belongs_to :wine
  
  def formatted_ship_date
    ship_date.strftime("%m/%d/%y")
  end
  
  def carrier
    track = TrackingNumber.new(tracking_number)
    track.carrier
  end
end
