module ProjectsHelper
  
  def project_component_title_for(project, component)
    arr = parse_requirement_for(project, component)
    if arr
      if arr.size == 1
        return project_component_header_for(component, arr.first.packageable)
      else
        return component.pluralize.titleize
      end
    else
      raise "Could not find #{component} association on project #{project}"
    end
  end
  
  def project_component_content_for(project, component)
    arr = parse_requirement_for(project, component)
    if arr
      if arr.empty?
        return render partial: 'partials/component_wrappers/empty_component_wrapper', locals: { component: component }
      elsif arr.size == 1
        return render partial: 'partials/component_wrappers/single_component_wrapper', locals: { collection: arr, component: component }
      else arr.size == 2
        return render partial: 'partials/component_wrappers/double_component_wrapper', locals: { collection: arr, component: component }
      end
    else
      raise "Could not find #{component} association on project #{project}"
    end
  end
  
  def project_component_header_for(component, object)
    title = component.titleize
    link  = component_link_for(object, class: "pull-right")
    [title, link].join(" ").html_safe
  end
  
  def component_link_for(object, options={})
    attribute = options[:attribute] ? options[:attribute] : :item_number
    link_to object.send(attribute), url_for(controller: object.class.to_s.tableize, action: :show, id: object.id), options
  end
  
  def parse_requirement_for(project, component)
    req = "#{component}_requirements".intern
    project.send(req)
  end
  
  def render_component_partial(component)
    render partial: "/partials/" + component + "_content" #, locals: { project: @project, component: component }
  end
end
