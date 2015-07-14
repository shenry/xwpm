# == Schema Information
#
# Table name: wines
#
#  id              :integer          not null, primary key
#  appellation     :string
#  variety         :string
#  vintage         :string
#  alc             :string
#  sample_number   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  treatments      :text
#  description     :text
#  vinx2_reference :string
#

class Wine < ActiveRecord::Base
  include CostHelper
  
  has_many  :projects, inverse_of: :wine
  has_many  :components, inverse_of: :wine
  has_many  :wine_shipments, inverse_of: :wine
  has_many  :reviewers, through: :wine_shipments, source: :customer
  
  validates :appellation, :appellation_percent, :variety, :variety_percent, :vintage, :vintage_percent,
            :alc, :sample_number, :cogs, :gallons, presence: true
  
  def to_s
    "[" + sample_number + "] " + vintage + " " + appellation + " " + variety
  end
  
  def component_percent_hash
    array = components.select(:id, :volume).map { |c| [c.id, (c.volume / blend_volume) * 100] }
    Hash[*array.flatten]
  end
  
  def blend_volume
    components.map(&:volume).compact.inject { |sum, v| sum + v.to_f }
  end
  
  def blend_percent_sum
    component_percent_hash.values.inject(0) { |sum, v| sum + v } 
  end
  
  def weighted_avg(attribute)
    attribute = attribute.to_s + "_percent" unless attribute.to_s == "cogs"
    sum_product = components.select(:volume, attribute.intern).inject(0) do |result, component| 
      result + component.send(attribute.intern) * component.volume
    end
    sum_product / blend_volume if ( sum_product && blend_volume )
  end
  
  def cases
    (blend_volume / 2.4).to_i if blend_volume
  end
  
  def display_alc
    return "N/A" if alc.nil?
    return alc.to_s + "%"
  end
end
