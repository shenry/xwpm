# == Schema Information
#
# Table name: components
#
#  id                  :integer          not null, primary key
#  wine_id             :integer
#  lot_number          :string
#  volume              :integer
#  description         :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  cogs                :float
#  appellation_percent :float            default(100.0)
#  vintage_percent     :float            default(100.0)
#  variety_percent     :float            default(100.0)
#

class Component < ActiveRecord::Base
  belongs_to :wine, inverse_of: :components
  
  validates :wine_id, :lot_number, :volume, :cogs, :vintage_percent,
            :appellation_percent, :variety_percent, presence: true

  validates_numericality_of :volume, :cogs, greater_than: 0
  validates_numericality_of :vintage_percent, :appellation_percent, :variety_percent,
                            greater_than_or_equal_to: 0
            
  before_create :upcase_lot_number
  
  def blend_percent
    total_volume = self.wine.blend_volume
    (volume / total_volume) * 100
  end
  
  private
  def upcase_lot_number
    lot_number.upcase!
  end
end
