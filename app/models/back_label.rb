class BackLabel < Label
  include PackagingComponent
  
  self.table_name = "labels"
  
  has_one  :vendor_product, as: :vendable
  has_one  :vendor, through: :vendor_product
  
  has_many :component_requirements, as: :packageable
  has_many :projects, through: :component_requirements
  
  def specs
    "#{height} x #{width} #{units}"
  end
  
  def width_placeholder
    "W"
  end
end