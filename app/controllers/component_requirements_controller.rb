class ComponentRequirementsController < ApplicationController

  def create
    @component_requirement = ComponentRequirement.new(requirement_params)
    @type = @component_requirement.packageable_type.underscore.downcase
    requirement = "#{@type}_requirements".intern
    @project  = @component_requirement.project
    parent    = @project.send(requirement).last
    @component_requirement.parent = parent  
    if @component_requirement.save
      respond_to do |wants|
        wants.js { } 
      end
    else
      puts "we have errors! #{@component_requirement.errors.inspect}"
    end
  end
  
  def destroy
    @component_requirement = ComponentRequirement.find(params[:id])
    @type = @component_requirement.packageable_type.underscore.downcase
    @project = @component_requirement.project
    if @component_requirement.destroy
      respond_to do |wants|
        wants.html { redirect_to project_path(@project)}
        wants.js {}
      end
    end
  end
  
  private
  def requirement_params
    params.require(:component_requirement).permit(:project_id, :packageable_id, :packageable_type)
  end
end