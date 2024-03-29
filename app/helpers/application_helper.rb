module ApplicationHelper
  DATE_FORMAT_STRING = "%m/%d/%y"
  
  def current_user_is_admin?
    current_user && current_user.admin?
  end
  
  def present_attr(string)
    arr = string.split("_")
    arr.map { |s| s.length <= 3 ? s.upcase : s.capitalize }.join(" ")
  end
  
  def conditional_image_link(image_parent, method, version)
    url = "#{method.to_s}_url".intern
    link_to_unless image_parent.send(method.intern).blank?, 
                    cl_image_tag(image_parent.send(url, version)), 
                    image_parent.send(url), target: :_blank
  end
  
  def markdown_link
    link_to "Markdown Reference", "https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet", target: :_blank, class:"pull-right"
  end
  
  def component_url_for(object, action)
    controller = object.class.to_s.underscore.downcase.pluralize
    url_for(controller: controller, action: action, id: object.id)
  end
  
  def google_tracking_url_for(shipment)
    "https://www.google.com/search?q=#{shipment.tracking_number}"
  end
  
  def title(value)
    unless value.nil?
      @title = "#{value} | X"
    end
  end
  
  def str_to_constant(str, gap="_")
    str.split(gap).each { |w| w.capitalize! }.join("").constantize
  end
  
  def model_to_controller(model_name)
    model_name.underscore.downcase.pluralize
  end
  
  def markup(string)
    markdown = BlueCloth.new(string).to_html.html_safe
  end
  
  def formatted_date(date, format=DATE_FORMAT_STRING)
    return date if date.is_a? String
    date.strftime(format)
  end
  
  def sub_nav_link_for(category, options={})
    cat_string  = category.to_s
    link_title  = options[:title] || cat_string.titleize
    if params[:category]
      li_class    = params[:category] == cat_string ? "active" : ""
    else
      li_class    = options[:default] ? "active" : ""
    end
    role        = options[:role] || "presentation"
    content_tag :li, class: li_class, role: role, id: "#{cat_string}_li" do
      link_to link_title, "?category=#{cat_string}", data: { remote: true }
    end
  end
  
  def us_states
      [
        ['Alabama', 'AL'],
        ['Alaska', 'AK'],
        ['Arizona', 'AZ'],
        ['Arkansas', 'AR'],
        ['California', 'CA'],
        ['Colorado', 'CO'],
        ['Connecticut', 'CT'],
        ['Delaware', 'DE'],
        ['District of Columbia', 'DC'],
        ['Florida', 'FL'],
        ['Georgia', 'GA'],
        ['Hawaii', 'HI'],
        ['Idaho', 'ID'],
        ['Illinois', 'IL'],
        ['Indiana', 'IN'],
        ['Iowa', 'IA'],
        ['Kansas', 'KS'],
        ['Kentucky', 'KY'],
        ['Louisiana', 'LA'],
        ['Maine', 'ME'],
        ['Maryland', 'MD'],
        ['Massachusetts', 'MA'],
        ['Michigan', 'MI'],
        ['Minnesota', 'MN'],
        ['Mississippi', 'MS'],
        ['Missouri', 'MO'],
        ['Montana', 'MT'],
        ['Nebraska', 'NE'],
        ['Nevada', 'NV'],
        ['New Hampshire', 'NH'],
        ['New Jersey', 'NJ'],
        ['New Mexico', 'NM'],
        ['New York', 'NY'],
        ['North Carolina', 'NC'],
        ['North Dakota', 'ND'],
        ['Ohio', 'OH'],
        ['Oklahoma', 'OK'],
        ['Oregon', 'OR'],
        ['Pennsylvania', 'PA'],
        ['Puerto Rico', 'PR'],
        ['Rhode Island', 'RI'],
        ['South Carolina', 'SC'],
        ['South Dakota', 'SD'],
        ['Tennessee', 'TN'],
        ['Texas', 'TX'],
        ['Utah', 'UT'],
        ['Vermont', 'VT'],
        ['Virginia', 'VA'],
        ['Washington', 'WA'],
        ['West Virginia', 'WV'],
        ['Wisconsin', 'WI'],
        ['Wyoming', 'WY']
      ]
  end
  
  def asset_data_base64(path)
    asset = Rails.application.assets.find_asset(path)
    throw "Could not find asset '#{path}'" if asset.nil?
    base64 = Base64.encode64(asset.to_s).gsub(/\s+/, "")
    "data:#{asset.content_type};base64,#{Rack::Utils.escape(base64)}"
  end
  
  def edit_component_requirement_path(requirement)
    component_id = requirement.packageable_id
    controller = requirement.packageable_type.underscore.pluralize.downcase
    if controller == "closures"
      controller = requirement.packageable.type.underscore.pluralize.downcase
    end
    { controller: controller, action: :show, id: component_id }
  end
end
