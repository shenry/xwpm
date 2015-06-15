# == Schema Information
#
# Table name: wines
#
#  id                  :integer          not null, primary key
#  name                :string           default(""), not null
#  description         :string           default(""), not null
#  appellation         :string
#  appellation_percent :string
#  variety             :string
#  variety_percent     :string
#  vintage             :string
#  vintage_percent     :string
#  alc                 :string
#  winemaker           :string
#  sample_number       :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Wine < ActiveRecord::Base
  has_many :projects
  
  validates :appellation, :appellation_percent, :variety, :variety_percent, :vintage, :vintage_percent,
            :alc, :sample_number, :cost_per_gallon, presence: true
  
  def to_s
    "[" + sample_number + "] " + vintage + " " + appellation + " " + variety
  end
end
