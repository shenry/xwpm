class Bottle < ActiveRecord::Base
  include PackagingComponent
  has_one   :vendor_product, as: :vendable, dependent: :destroy
  has_one   :vendor, through: :vendor_product

  has_many :component_requirements, as: :packageable
  has_many :projects, through: :component_requirements
  
  validates :item_number, :fill_point, :mould, :color, :shape, presence: true
  
  def initialize(params={})
    super
    self.units = "mm"
  end
  
  def specs
    "#{height} x #{diameter} #{units}"
  end
  
  def formatted_case_dimensions
    string  = case_dimensions
    matches = string.match(/(\d+)\s(\d+\/\d+)\sx\s(\d+)\s(\d+\/\d+)\sx\s(\d+)\s(\d+\/\d+)?/).captures
    output = "#{matches[0]} #{add_markup(matches[1])} &nbsp;x&nbsp; #{matches[2]} #{add_markup(matches[3])} &nbsp;x&nbsp; #{matches[4]} #{add_markup(matches[5])}"
    output.html_safe
  end
  
  def case_config
    "#{bottles_per_case} x #{capacity} #{capacity_units}"
  end
  
  def finish_collection
    [["Cork", "Cork"], ["Screwcap", "Screwcap"], ["Bar Top", "Bar Top"]]
  end
  
  private
  
  def add_markup(string)
    return string unless string.include? "/"
    matches = string.match(/(\d+)\/(\d+)/).captures
    first   = "<sup>#{matches[0]}</sup>"
    second  = "<sub>#{matches[1]}</sub>"
    [first,second].join("/")
  end
end