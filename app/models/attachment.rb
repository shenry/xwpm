class Attachment < ActiveRecord::Base
  belongs_to :packaging_component, polymorphic: true
  mount_uploader :asset, AssetUploader
  
end
