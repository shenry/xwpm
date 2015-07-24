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

class Screwcap < Closure
  has_one   :vendor_product, as: :vendable, dependent: :destroy
  has_one   :vendor, through: :vendor_product  
end
