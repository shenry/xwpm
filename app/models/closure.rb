# == Schema Information
#
# Table name: closures
#
#  id          :integer          not null, primary key
#  type        :string
#  item_number :string
#  material    :string
#  color       :string
#  height      :string
#  width       :string
#  units       :string
#  has_artwork :boolean          default(FALSE), not null
#  artwork     :string
#  image       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  active      :boolean          default(TRUE)
#

class Closure < ActiveRecord::Base
  include PackagingComponent
  
  has_many  :component_requirements, as: :packageable
  has_many  :projects, through: :component_requirements
  
  # don't join :vendor, since closure is unaware of vendors
  scope :active, -> { where(active: true) }
  
  mount_uploader :artwork, ImageUploader
  
  class << self
    def grouped_for_select
      active.group_by(&:type).map { |type, arr| [type, arr.map { |i| [i.to_s, i.id] } ] }
    end
  end
  
  def specs
    "#{height} x #{diameter} #{units}"
  end
end
