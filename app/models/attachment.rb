# == Schema Information
#
# Table name: attachments
#
#  id          :integer          not null, primary key
#  asset       :string
#  parent_id   :integer
#  parent_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  title       :string           default("")
#  description :text             default("")
#

class Attachment < ActiveRecord::Base
  belongs_to :packaging_component, polymorphic: true
  mount_uploader :asset, AssetUploader
  
  def self.remove_image(val)
    puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx................xxxxxxxxx"
    image_will_change! if val
    super
  end
end
