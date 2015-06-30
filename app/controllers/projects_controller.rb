class ProjectsController < ApplicationController
  before_action :autocomplete_collections, only: [:new, :create, :edit, :update]
  
  def show
    @project = Project.includes(:wine, :customer, :comments).find(params[:id])
    @comment = @project.comments.build(author_id: current_user.id)
    if params[:alt] == "true"
      render :alt_show
    else
      render :show
    end
  end
  
  def show_component
    @component  = params[:component]
    if @component == "packaging_components"
      @project = Project.find(params[:id])
    elsif @component == "shipping"
      @project = Project.find(params[:id])
    elsif @component == "finance"
      
    else # a legit association, either :wine or :comments
      @project    = Project.includes(@component.intern).find(params[:id])
    end
    @component_path = @component + "_content"
    
    respond_to do |wants|
      wants.js {}
    end
  end

  def index
    if params[:customer_id]
      @customer = Customer.includes(:projects).find(params[:customer_id])
      @projects = @customer.projects
    else
      @projects = Project.includes(:customer, :wine, :comments)
    end
  end

  def new
    @customer = Customer.includes(:projects).find(params[:customer_id])
    @project = @customer.projects.build(:project_number => "")
  end
  
  def create
    @customer = Customer.find(params[:customer_id])
    unless params[:project][:wine_id].blank?
      params[:project].delete("wine_attributes")
    end
    @project = @customer.projects.new(project_params)
    
    if @project.save
      redirect_to customer_projects_path(@customer)
    else
      render :new, { :project => @project, :customer => @customer }
    end
  end

  def edit
    @project = Project.find(params[:id])
    @project.bottling_date = @project.formatted_bottling_date
  end
  
  def update
    @project = Project.find(params[:id])
    date     = params[:project][:bottling_date]
    @project.update_attributes(project_params)
    @project.bottling_date = Date.strptime(date, ProjectsHelper::BOTTLING_DATE_FORMAT_STRING) if date
    if @project.save
      redirect_to project_path(@project)
    else
      render action: :edit
    end
  end
  
  def remove
    @project = Project.find(params[:id])
    @association = params[:association]
    @association = "closure" if ["cork", "screwcap"].include? @association
    @project.send("#{@association}=", nil)
    @project.save
    
    respond_to do |wants|
      wants.html { redirect_to project_path(@project) }
      wants.js { }
    end
  end
  
  private
  def autocomplete_collections
    @brands       = Project.all.map(&:brand)
    @varieties    = Wine.all.map(&:variety)
    @appellations = Wine.all.map(&:appellation)
  end
  
  def project_params
    params.require(:project).permit(:customer_id, :project_number, :brand, :variety, :winemaker, :target_cases, :wine_id,
                                    :bottle_id, :shipper_id, :closure, :closure_id, :capsule_id, :front_label_id, :back_label_id,
                                    :bottling_date, :qb_code, :trucker, :cases_to_customer, :fob, :fso2_target, :max_do)
  end
end
