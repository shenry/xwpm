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

class PackagingComponent < ActiveRecord::Base
  belongs_to  :vendor, inverse_of: :packaging_components
  has_many    :attachments, as: :parent, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true
  
  mount_uploader  :image, ImageUploader
  
  validates  :type, presence: true
  
  before_save :upcase_item_identifier, :generate_code
  
  def model_nickname
    name = self.model_name.to_s
    name = "Closure" if ["Cork", "Screwcap"].include? name
    name.underscore.downcase
  end
  
  def self.grouped_closures(sort=nil)
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
  
  # def case_weight
  #   if self.is_a? Bottle
  #     out = read_attribute(:case_weight)
  #     return out.to_s + "Lbs"
  #   end
  # end
  
  def description
    [vendor.name, material, self.model_name.to_s.titleize, specs, capacity_string(false)].join(" ")
  end
  
  def self.width_or_diameter
    return "diameter" if [Cork, Capsule, Bottle].include? self
    "width"
  end
  
  def self.spec_select_options
    ['mm', 'in']
  end
  
  def closure_select_options
    ['Cork', 'Screwcap']
  end
  
  def self.has_depth?
    return true if self == Shipper
    false
  end
  
  def self.capacity_description
    if self == Bottle
      "volume"
    elsif self == Shipper
      "bottles"
    else
      nil
    end
  end

  def specs
    "#{height}#{units} x #{width}#{units}"
  end
  
  def capacity_string(option=true)
    "#{bottle_capacity} #{bottle_capacity_units}"
  end
  
  def fill_point_string
    raise 'Incompatible Packaging Component Type' unless self.is_a? Bottle
    "#{fill_point}#{fill_point_units}"
  end
  
  def color_code
    return "" unless self.color
    color_code_table[self.color.downcase] || self.color[0..2].upcase
  end
  
  def mould_code
    self.mould || ""
  end
  
  def shape_code
    return "" unless self.shape
    shape_code_table[self.shape.downcase] || self.shape[0..2].upcase
  end
  
  def color_class
    
  end
  
  def spec_code
    super
  end
  
  def material_code
    return "" unless self.material
    material_code_table[self.material.downcase] || self.material[0..2].upcase
  end
  
  def to_s
    vendor.name + " - " + code
  end
  
  def controller_class
    self.class.to_s.underscore.downcase.pluralize
  end
  
  private
  
  def save_corks_and_screwcaps_as_closures
    self.type = "Closure" if self.is_a? Cork
    self.type = "Closure" if self.is_a? Screwcap
  end
  
  def upcase_item_identifier
    self.item_identifier.upcase!
  end
  
  def material_code_table
    { "tin"           => "TIN",
      "polylam"       => "PLY",
      "polylaminate"  => "PLY",
      "colmated"      => "COL"
    }
  end
  
  def color_code_table
    { "black" => "BLK",
      "white" => "WHT",
      "red" => "RED",
      "pink" => "PNK",
      "green" => "GRN",
      "blue" => "BLU",
      "yellow" => "YEL",
      "gold" => "GLD",
      "silver" => "SLV" }
  end
  
  def shape_code_table
    { "claret" => "CLT",
      "burgundy" => "BGY",
      "hock" => "HOC" }
  end
  
  def generate_code
    vendor_code   = self.vendor.code
    color_code    = self.color_code
    material_code = self.material_code
    mould_code    = self.mould_code
    shape_code    = self.shape_code
    item_code     = self.item_identifier
    spec_code     = self.spec_code    || ""
    
    self.code = vendor_code + mould_code + material_code + color_code + shape_code + item_code + spec_code
  end
end
