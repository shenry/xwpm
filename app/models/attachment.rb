class Attachment < ActiveRecord::Base
  belongs_to :packaging_component, polymorphic: true
  mount_uploader :asset, AssetUploader
  
  def self.remove_image(val)
    puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx................xxxxxxxxx"
    image_will_change! if val
    super
  end
end
