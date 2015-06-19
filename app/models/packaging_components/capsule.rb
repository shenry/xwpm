class Capsule < PackagingComponent
  has_many  :projects
  
  def spec_code
    if self.height == "55" && self.units == "mm"
      output = self.width.gsub('.', '')
    else
      output = self.height.gsub('.', '') + "X" + self.width.gsub('.', '')
      output += self.units.upcase unless self.units == "mm"
    end
    output
  end
end