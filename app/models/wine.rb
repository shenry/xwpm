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
  include AASM
  
  has_many  :projects, inverse_of: :wine
  has_many  :components, -> { order("created_at ASC") }, inverse_of: :wine, dependent: :destroy
  has_many  :wine_shipments, inverse_of: :wine, dependent: :destroy
  has_many  :reviewers, through: :wine_shipments, source: :customer
  
  default_scope { eager_load(:components) }
  
  validates :appellation, :variety, :vintage, :alc, :sample_number, presence: true
  validates :alc, :vintage, numericality: true
  validates :sample_number, uniqueness: true
  
  before_save :upcase_vinx2_reference
  
  aasm do
    state :active, initial: true
    state :inactive
    
    event :deactivate do
      transitions from: :active, to: :inactive
    end
    event :reactivate do
      transitions from: :inactive, to: :active
    end
  end
  
  def to_s
    "[" + sample_number + "] " + vintage + " " + appellation + " " + variety
  end
  
  def self.select_options
    # TODO - reference active only
    order(sample_number: :desc).map { |w| [w.to_s, w.id] }
  end
  
  def component_percent_hash
    array = components.select(:id, :volume).map { |c| [c.id, (c.volume.to_f / blend_volume.to_f) * 100] }
    Hash[*array.flatten]
  end
  
  def blend_volume
    vol = components.map(&:volume).compact.inject { |sum, v| sum + v.to_f }
    vol.to_i if vol
  end
  
  def blend_percent_sum
    component_percent_hash.values.inject(0) { |sum, v| sum + v } 
  end
  
  def weighted_avg(attribute)
    attribute = attribute.to_s + "_percent" unless attribute.to_s == "cogs"
    sum_product = components.inject(0) do |result, component| 
      component.id ? result + component.send(attribute.intern) * component.volume : result
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
  
  private
  
  def upcase_vinx2_reference
    vinx2_reference.upcase!
  end
end
