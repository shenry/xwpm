class ComponentRequirementsController < ApplicationController

  def create
    @component_requirement = ComponentRequirement.new(requirement_params)
    if @component_requirement.save
      @project  = @component_requirement.project
      @type     = @component_requirement.packageable_type.underscore.downcase
      respond_to do |wants|
        wants.js { } 
      end
    else
      puts "we have errors! #{@component_requirement.errors.inspect}"
    end
  end
  
  def destroy
    
  end
  
  private
  def requirement_params
    params.require(:component_requirement).permit(:project_id, :packageable_id, :packageable_type)
  end
end