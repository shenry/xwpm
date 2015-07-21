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
  require 'aftership'
  AfterShip.api_key = "e5a74356-8a93-4c6c-bd16-006a52e9e987"
  
  belongs_to :customer, class_name: "Firm"
  belongs_to :wine
  
  def self.allowed_carriers
    ["FedEx", "UPS", "USPS"]
  end
  
  validates :tracking_number, :carrier, :ship_date, :customer_id, :wine_id, presence: true
  validates :carrier, inclusion: { in: self.allowed_carriers }
  validate  :tracking_number_belongs_to_carrier
  

  
  def formatted_ship_date
    ship_date.strftime("%m/%d/%y")
  end
  
  def current_status
    status.titleize
  end
  
  def tracking_status
    unless status == "Delivered"
      check_status
    end
    current_status
  end
  
  def tracking_status_class
    status.underscore.downcase
  end
  
  def parse_response(response)
    code = response["meta"]["code"]
    if code == "200"
      message = response["data"]["checkpoint"]["tag"]
    else
      message = response["meta"]["message"]
    end
    Response.new(code, message)
  end
  
  def check_status
    if current_status == nil || updated_at < 15.minutes.ago
      response = get_checkpoint!
      message  = response["data"]["checkpoint"]["tag"]
      self.update_attribute(:status, message)
    end
  end
  
  private
  def tracking_number_belongs_to_carrier
    response = get_checkpoint!
    unless response["meta"]["code"] == 200
      errors.add(:tracking_number, "not found for carrier.")
    end
  end
  
  def get_checkpoint!
    AfterShip::V4::LastCheckpoint.get(carrier.downcase, tracking_number)
  end
end
