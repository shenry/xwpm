module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | X"
    end
  end
end
