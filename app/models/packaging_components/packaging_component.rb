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

class PackagingComponent < ActiveRecord::Base

  def specs
    output = "#{height}#{units} x #{width}#{units}"
    if self.is_a? Shipper
      output << " x #{depth}#{units}"
    end
    output
  end
  
  def capacity_string
    if self.is_a? Bottle 
      "#{capacity} #{capacity_units}"
    elsif self.is_a? Shipper
      "#{capacity} x #{capacity_units}"    
    else
      raise "Only Bottles and Shippers can have a capacity."
    end
  end
end
