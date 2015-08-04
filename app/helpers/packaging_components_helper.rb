module PackagingComponentsHelper
  def format_position(num, unit="mm")
    "#{num}#{unit}" if num
  end
end
