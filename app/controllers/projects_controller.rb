class ProjectsController < ApplicationController
  before_action :autocomplete_collections, only: [:new, :create, :edit, :update]
  
  def show
    @project = Project.includes(:wine, :customer).find(params[:id])
  end

  def index
    if params[:customer_id]
      @customer = Customer.includes(projects: [:wine]).find(params[:customer_id])
      @projects = @customer.projects
    else
      @projects = Project.includes(:customer, :wine)
    end
  end

  def new
    @customer = Customer.includes(:projects).find(params[:customer_id])
    @project = @customer.projects.build(:project_number => "")
    # @project.wine = Wine.new
    # @project.package = Package.new
  end
  
  def create
    @customer = Customer.find(params[:customer_id])
    puts "Projects are #{Project.all.inspect}"
    unless params[:project][:wine_id].blank?
      params[:project].delete("wine_attributes")
    end
    @project = @customer.projects.new(project_params)
    
    if @project.save
      redirect_to customer_projects_path(@customer)
    else
      puts "nope!!!!!! errors on @project: #{@project.errors.inspect}"
      render :new, { :project => @project, :customer => @customer }
    end
  end

  def edit
    @project = Project.find(params[:id])
    @project.bottling_date = @project.formatted_bottling_date
    puts "@project = #{@project.inspect}"
  end
  
  def update
    @project = Project.find(params[:id])
    @project.update_attributes(project_params)
    if @project.save
      redirect_to project_path(@project)
    else
      render action: :edit
    end
  end
  
  private
  def autocomplete_collections
    @brands       = Project.all.map(&:brand)
    @varieties    = Wine.all.map(&:variety)
    @appellations = Wine.all.map(&:appellation)
  end
  
  def project_params
    params.require(:project).permit(:customer_id, :project_number, :brand, :variety, :winemaker, :target_cases, :wine_id, :package_id,
                                    wine_attributes: [:sample_number, :vintage, :vintage_percent, :variety, :variety_percent, :appellation,
                                      :appellation_percent, :treatments, :description, :cost_per_gallon])
  end
end
