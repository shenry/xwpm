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

class Shipper < PackagingComponent
  belongs_to    :vendor
  has_many      :packages
  before_create :set_defaults
  
  def self.spec_select_options
    ['mm', 'in']
  end
  
  def self.capacity_select_options
    ['375mL', '750mL', '1.5L', '3L']
  end
  
  private
  def set_defaults
    capacity_units = '750mL'
  end
end
