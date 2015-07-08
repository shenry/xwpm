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
