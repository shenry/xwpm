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
#  quantity    :integer          default(0)
#  aasm_state  :string
#

class Screwcap < Closure

end
