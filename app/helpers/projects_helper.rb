module ProjectsHelper
  
  def display_admin_project_state(project, options={})
    # user = options[:current_user]
    if current_user_is_admin?
      render partial: "admin/project_state_select", locals: { project: project }
    else
      render partial: "projects/state_badge", locals: { project: project }
    end
  end
  
  def states_for_select(project)
    # friendly_names = project.aasm_state_names.collect { |n| [n.to_s.titleize, n.to_s] }
    friendly_names = project.aasm_state_names.collect do |name|
      value = project.events_map[name] || name
      [name.to_s.titleize, value]
    end
    disabled_names = project.aasm_state_names - project.permitted_aasm_state_names
    puts "disabled_names = #{disabled_names.inspect}"
    options_for_select(friendly_names, selected: project.aasm_state.downcase, 
                      disabled: disabled_names)
  end
  
  def project_component_title_for(project, component)
    arr = parse_requirement_for(project, component)
    if arr
      if arr.size == 1
        return project_component_header_for(component, arr.first)
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
  
  def project_component_header_for(component, component_requirement)
    title = component.titleize
    component_object = component_requirement.packageable
    show_link  = component_link_for(component_object, action: :show, id: component_object.id, class: "pull-right title-link")
    delete_link = delete_link_for(component_requirement, action: :index, method: :destroy, class: "pull-right")
    span = content_tag :span, id: "#{title.underscore.downcase}-manager-links" do
      [delete_link, show_link].join('').html_safe
    end
    [title, span].join(" ").html_safe
  end
  
  def delete_link_for(component_requirement, options)
    link_to(url_for(controller: "component_requirements", action: :show, id: component_requirement.id),
                    data: { method: :delete,
                      confirm: "Are you sure you want to remove this #{component_requirement.packageable.class.to_s.titleize} from the Project?",
                      remote: true }, class: "pull-right destroy") do
      "<span class='glyphicon glyphicon-remove'></span>".html_safe
    end
  end
  
  def component_link_for(component_object, options={})
    attribute = options[:attribute] ? options[:attribute] : :item_number
    title     = options.delete(:title) || component_object.send(attribute)
    link_to(title, url_for(component_object), options)
      # link_to(title, component_url_for(component_object, action: :show, id: component_object.id), options)
  end
  
  def parse_requirement_for(project, component)
    req = "#{component}_requirements".intern
    project.send(req)
  end
  
  def render_component_partial(component)
    render partial: "/partials/" + component + "_content"
  end
end
