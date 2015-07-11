class Closure < ActiveRecord::Base
  include PackagingComponent
  
  has_many  :component_requirements, as: :packageable
  has_many  :projects, through: :component_requirements
  
  scope :active, -> { where(active: true) }
  
  mount_uploader :artwork, ImageUploader
  
  def specs
    "#{height} x #{diameter} #{units}"
  end
end