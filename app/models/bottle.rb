# == Schema Information
#
# Table name: bottles
#
#  id               :integer          not null, primary key
#  item_number      :string
#  mould            :string
#  shape            :string
#  color            :string
#  height           :string
#  width            :string
#  neck_diameter    :string
#  units            :string
#  finish           :string
#  fill_point       :string
#  capacity         :integer
#  capacity_units   :string
#  bottles_per_case :string
#  case_dimensions  :string
#  pallet_config    :string
#  case_weight      :string
#  image            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  active           :boolean          default(TRUE)
#

class Bottle < ActiveRecord::Base
  include PackagingComponent
  has_one  :vendor_product, as: :vendable, dependent: :destroy
  has_one  :vendor, through: :vendor_product

  has_many :component_requirements, as: :packageable, dependent: :destroy
  has_many :projects, through: :component_requirements
  
  validates :item_number, :mould, :color, :shape, :height, :width, 
            :neck_diameter, :units, :finish, :capacity, :capacity_units, :bottles_per_case, 
            :case_dimensions, :pallet_config, :case_weight, :active, presence: true
            
  validates :fill_point, :height, :width, :neck_diameter, :capacity, 
            :case_weight, numericality: true
  validates :bottles_per_case, numericality: { only_integer: true }
  
  
  def initialize(params={})
    super
    self.units = "mm"
  end
  
  class << self
    def capacity_options
      [['mL', 'mL'], ['oz', 'oz']]
    end
    def finish_options
      [["Cork", "Cork"], ["Screwcap", "Screwcap"], ["Bar Top", "Bar Top"]]
    end
  end
  
  def specs
    "#{height} x #{diameter} #{units}"
  end
  
  def formatted_case_dimensions
    string  = case_dimensions
    matches = string.match(/(\d+)\s(\d+\/\d+)\sx\s(\d+)\s(\d+\/\d+)\sx\s(\d+)\s(\d+\/\d+)?/).captures
    output = "#{matches[0]} #{add_markup(matches[1])} &nbsp;x&nbsp; #{matches[2]} #{add_markup(matches[3])} &nbsp;x&nbsp; #{matches[4]} #{add_markup(matches[5])}"
    output.html_safe
  end
  
  def case_config
    "#{bottles_per_case} x #{capacity} #{capacity_units}"
  end
  
  def finish_collection
    [["Cork", "Cork"], ["Screwcap", "Screwcap"], ["Bar Top", "Bar Top"]]
  end
  
  def capacity_options
    self.class.send :capacity_options
  end
  
  private
  
  def add_markup(string)
    return string unless string.include? "/"
    matches = string.match(/(\d+)\/(\d+)/).captures
    first   = "<sup>#{matches[0]}</sup>"
    second  = "<sub>#{matches[1]}</sub>"
    [first,second].join("/")
  end
end
