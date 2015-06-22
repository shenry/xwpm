class Screwcap < Closure
  
  def initialize(params=nil)
    super
    self.closure_type = "Screwcap"
  end
  
  def color_class
    "bg-warning" # yellow
  end
end