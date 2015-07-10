module BottlesHelper
  # def formatted_case_dimensions(case_dimensions)
  #   string  = case_dimensions
  #   matches = string.match(/(\d+)\s(\d+\/\d+)\sx\s(\d+)\s(\d+\/\d+)\sx\s(\d+)\s(\d+\/\d+)?/).captures
  #   output = "#{matches[0]} #{add_markup(matches[1])} &nbsp;x&nbsp; #{matches[2]} #{add_markup(matches[3])} &nbsp;x&nbsp; #{matches[4]} #{add_markup(matches[5])}"
  #   output.html_safe
  # end
  #
  def add_markup(string)
    return string unless string.include? "/"
    matches = string.match(/(\d+)\/(\d+)/).captures
    first   = "<sup>#{matches[0]}</sup>"
    second  = "<sub>#{matches[1]}</sub>"
    [first,second].join("/")
  end
end