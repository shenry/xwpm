module FirmsHelper
  def render_firm_partial(category)
    header = "<h3>#{category.titleize}</h3>"
    if %w(bottles capsules closures front_labels back_labels).include? category
      table = render partial: "#{category}/table", locals: { components: @firm.send(category) }
    else
      table = render partial: "firms/#{category}_content"
    end
    (header + table).html_safe
  end
end