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

class XClosure < PackagingComponent
  # belongs_to  :vendor
  # has_many    :projects
  
  before_save :set_type
  
  validates :material, :color, presence: true
  
  def self.grouped_children(sort=nil)
    sort ||= :created_at
    corks = Cork.order(sort)
    screwcaps = Screwcap.order(sort)
    output = []
    cork_array = corks.map { |c| [c.to_s, c.id] }
    screwcap_array = screwcaps.map { |s| [s.to_s, s.id] }
    output << ["Corks", cork_array]
    output << ["Screwcaps", screwcap_array]
    output
  end
  
  def spec_code
    item_identifier || ""
  end
  
  private
  def set_type
    # if [Cork, Screwcap].include? self.class
    #   self.type = "Closure"
    # end
  end
  
end
