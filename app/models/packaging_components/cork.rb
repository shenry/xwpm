class Cork < Closure
  
  def initialize(params=nil)
    super
    self.closure_type = "Cork"
  end
  
  def color_class
    "bg-warning" # yellow
  end
end