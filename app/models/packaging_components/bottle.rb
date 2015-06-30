# == Schema Information
#
# Table name: packaging_components
#
#  id               :integer          not null, primary key
#  type             :string
#  name             :string           default(""), not null
#  description      :string           default(""), not null
#  vendor_id        :integer
#  mould            :string
#  shape            :string
#  color            :string
#  height           :string
#  height_units     :string
#  width            :string
#  width_units      :string
#  depth            :string
#  depth_units      :string
#  fill_point       :string
#  fill_point_units :string
#  material         :string
#  has_artwork      :boolean          default(FALSE)
#  capacity         :string
#  capacity_units   :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  label_alc        :string
#  upc              :string
#  closure_type     :string
#  artwork_source   :string
#

class Bottle < PackagingComponent
  include BottlesHelper
  
  has_many    :projects
  
  validates :mould, :shape, :color, :height, :width, :units, :fill_point, :fill_point_units, 
            :bottle_capacity, :bottle_capacity_units, :case_capacity, :carton_size, :case_weight, presence: true
  validates_presence_of :vendor
  
  def spec_code
    return self.bottle_capacity if self.bottle_capacity_units == "mL"
    return self.bottle_capacity.gsub('.', '') + self.bottle_capacity_units.upcase
  end
  
  def format
    case_capacity + " x " + bottle_capacity + " " + bottle_capacity_units
  end
  
  def self.capacity_select_options
    ['mL', 'L', 'oz']
  end
  
  def color_class
    "bg-success" #green
  end
  
  # def to_s
  #   vendor.name + " - " + code
  # end
end
