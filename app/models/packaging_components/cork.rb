class Cork < PackagingComponent
  belongs_to  :vendor
  has_many    :projects, as: :closure
  
  def color_class
    "bg-warning" # yellow
  end
  
  def spec_code
    
  end
end