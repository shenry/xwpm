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

class FrontLabel < Label

  validates :vendor_id, :label_alc, :height, :width, :units, :label_position, :label_treatment, :label_rewind, :label_cut, 
            :artwork_source, presence: true

  def initialize(params=nil)
    super
    self.label_type = "FrontLabel"
  end
  
  def spec_code
    "specspec"
  end
  
  def color_class
    "bg-danger"
  end
end
