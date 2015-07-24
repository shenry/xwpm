# == Schema Information
#
# Table name: back_labels
#
#  id             :integer          not null, primary key
#  vendor_id      :integer
#  item_number    :string
#  height         :string
#  width          :string
#  units          :string
#  material       :string
#  alc            :string
#  upc            :string
#  rewind         :string
#  cut            :string
#  position       :string
#  treatment      :string
#  artwork_source :string
#  image          :string
#  artwork        :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  active         :boolean          default(TRUE)
#

class BackLabel < ActiveRecord::Base
  include PackagingComponent
  
  has_many  :component_requirements, as: :packageable, dependent: :destroy
  has_many  :projects, through: :component_requirements
  
  has_one  :vendor_product, as: :vendable, dependent: :destroy
  has_one  :vendor, through: :vendor_product
  
  def specs
    "#{height} x #{width} #{units}"
  end
  
  def width_placeholder
    "W"
  end
end
