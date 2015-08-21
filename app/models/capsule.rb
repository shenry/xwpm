# == Schema Information
#
# Table name: capsules
#
#  id          :integer          not null, primary key
#  item_number :string
#  height      :string
#  width       :string
#  units       :string
#  material    :string
#  color       :string
#  has_artwork :boolean          default(FALSE), not null
#  image       :string
#  artwork     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  active      :boolean          default(TRUE)
#

class Capsule < ActiveRecord::Base
  include PackagingComponent
  
  has_many  :component_requirements, as: :packageable, dependent: :destroy
  has_many  :projects, through: :component_requirements
  has_one   :vendor_product, as: :vendable, dependent: :destroy
  has_one   :vendor, through: :vendor_product
  
  validates :item_number, :height, :width, :units, :material, :color, presence: true
  validates :height, :width, numericality: true
  
  mount_uploader :artwork, ImageUploader
  
  def specs
    "#{height} x #{diameter} #{units}"
  end
end
