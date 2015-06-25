class Screwcap < PackagingComponent
  belongs_to  :vendor
  has_many    :projects, as: :closure
  
  def spec_code
    
  end
  
  def color_class
    "bg-warning" # yellow
  end
end