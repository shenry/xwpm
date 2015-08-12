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
#  status          :string
#  accepted        :boolean          default(FALSE)
#  message         :string
#

class WineShipment < ActiveRecord::Base
  require 'easypost'
  
  belongs_to :customer, class_name: "Firm"
  belongs_to :wine
  
  validates :tracking_number, :ship_date, :customer_id, :wine_id, presence: true
  
  before_save :fetch_tracking_status
  # TODO - create webhooks to update tracking status in production
  
  def formatted_ship_date
    ship_date.strftime("%m/%d/%y")
  end
  
  def current_status
    status.titleize
  end

  private
  # TODO - Abstract retrieval of tracking status to be applicable for before_create and webhook methods
  def fetch_tracking_status
    begin
      tracker = track(tracking_number)
      message = extract_message(tracker)
      self.status = tracker.status
      self.message= message
    end
  end
  
  def track(code)
    EasyPost::Tracker.create tracking_code: code
  end
  
  def extract_message(tracker)
    tracker.tracking_details.last["message"] || "ERR"
  end
end
