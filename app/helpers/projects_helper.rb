module ProjectsHelper
  
  def render_component_partial(component)
    render partial: "/partials/" + component + "_content" #, locals: { project: @project, component: component }
  end
  
  def attr_summary_array_for(object, category=nil)
    if category && (object.is_a? Project)
      if category == :shipping
        [["Foo", "Bar"]]
      end
    elsif object.is_a? Bottle
      [
        ["Vendor", link_to(object.vendor.name, vendor_path(object.vendor))],
        ["Format", object.bottles_per_case + " x " + object.capacity_units],
        ["Mould", object.mould],
        ["Color", object.color],
        ["Shape", object.shape],
        ["Specs", object.specs],
        ["Fill Point", object.fill_point + "mm"]
      ]
    elsif object.is_a? BackLabel
      [
        ["Vendor", link_to(object.vendor.name, vendor_path(object.vendor))],
        ["Position", object.position + "mm"],
        ["Specs", object.specs],
        ["Artwork", object.artwork_source]
      ]
    elsif object.is_a? Capsule
      [
        ["Vendor", link_to(object.vendor.name, vendor_path(object.vendor))],
        ["Material", object.material],
        ["Color", object.color],
        ["Specs", object.specs]
      ]
    elsif object.is_a? Cork
      [
        ["Vendor", link_to(object.vendor.name, vendor_path(object.vendor))],
        ["Material", object.material],
        ["Color", object.color],
        ["Specs", object.specs]
      ]
    elsif object.is_a? Screwcap
      [
        ["Vendor", link_to(object.vendor.name, vendor_path(object.vendor))],
        ["Material", object.material],
        ["Color", object.color],
        ["Specs", object.specs]
      ]
    else
      
    end
  end
end
