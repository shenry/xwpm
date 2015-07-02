class ProjectsController < ApplicationController
  before_action :autocomplete_collections, only: [:new, :create, :edit, :update]
  
  def show
    @project = Project.includes(:wine, :customer, :comments).find(params[:id])
    @comment = @project.comments.build(author_id: current_user.id)
    if params[:alt] == "true"
      render :alt_show
    else
      render :alt_show
    end
  end
  
  def show_spec_sheet
    @project = Project.find(params[:id])
    
    respond_to do |wants|
      wants.html
      wants.pdf do
        render  pdf: "spec-sheet-#{@project.to_s.downcase.gsub(" ", "-")}"
      end
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
    @customer_options = Customer.select_options
  end

  def new
    @customer = Customer.includes(:projects).find(params[:customer_id])
    @project = @customer.projects.build(:project_number => "")
  end
  
  def clone
    @project = Project.joins(:customer).find(params[:id])
    @old_project_number = @project.project_number
    @project.project_number = ""
    @project.bottling_date  = nil
    @customer = @project.customer
    render :new
  end
  
  def create
    @customer = Customer.find(params[:customer_id])
    unless params[:project][:wine_id].blank?
      params[:project].delete("wine_attributes")
    end
    puts "params are #{params.inspect}"
    @project = @customer.projects.new(project_params)
    bottling_date = params[:project][:bottling_date]
    puts "bottling_date = #{bottling_date}"
    @project.bottling_date = Date.strptime(bottling_date, "%m/%d/%y")
    
    if @project.save
      redirect_to customer_projects_path(@customer)
    else
      puts "Errors: #{@project.errors.messages}"
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
                                    :bottling_date, :qb_code, :trucker, :cases_to_customer, :fob, :fso2_target, :max_do,
                                    :vintage, :appellation, :taxes, :no_capsule)
  end
end
