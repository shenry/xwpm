module CostHelper
  def price(attr)
    string = self.send(attr)
    return "TBD" if string.blank?
    string
  end
end