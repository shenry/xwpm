class ProjectsController < ApplicationController
  include ApplicationHelper
  before_action :autocomplete_collections, only: [:new, :create, :edit, :update]
  before_action :fetch_by_project_id, only: [:in_development, :active, :ready, :bottled, :costed, :closed, :cancelled]
  
  def show
    respond_to do |wants|
      wants.html {
        @project = Project.find(params[:id])
        @comment = @project.comments.build(author_id: current_user.id)
        @component = params[:category] || "packaging_components" 
      }
      wants.js {
        @project ||= Project.find(params[:id])
        @component = params[:category] || "packaging_components" 
      }
    end
  end
  
  def show_spec_sheet
    @project = Project.find(params[:id])
    
    respond_to do |wants|
      wants.html
      wants.pdf do
        render  pdf: "spec-sheet-#{@project.to_s.downcase.gsub(" ", "-")}",
        footer: { content: project_path(@project) + "/spec_sheet.pdf" }
      end
    end
  end
  
  # Controller methods for triggering state change in projects
  [:activate, :deactivate, :cancel, :un_cancel, :make_ready, :bottle, :cost, :close].each do |method|
    define_method method do
      fetch_by_project_id
      respond_to do |wants|
        wants.js {
          @project.send(method.to_s + "!") if current_user.admin?
          render :project_state_change
        }
      end
    end
  end
  
  # def components_select
  #   project = Project.find(params[:id])
  #   @components = project.components_for_select(params[:vendor_id])
  #   respond_to do |wants|
  #     wants.js { render "purchase_orders/components_select" }
  #   end
  # end

  def index
    @projects = Project.fetch_filtered(params).text_search(params[:query]).page params[:page]
    
    respond_to do |wants|
      wants.html
      wants.js { render "project_vendors.js" }
    end
  end

  def new
    @customer = Customer.includes(:projects).find(params[:customer_id])
    @project = @customer.projects.build(:project_number => "")
    @project.components.build
  end
  
  def clone
    @old_project = Project.joins(:customer).find(params[:id])
    @project = Project.new(@old_project.attributes)
    @project.project_number = ""
    @project.bottling_date  = nil
    @customer = @project.customer
    
    respond_to do |wants|
      wants.html { render :new }
      wants.js { render js: "window.location.href='"+clone_project_path(@project)+"'" }
    end
  end
  
  def create
    @customer = Customer.find(params[:customer_id])
    @project = @customer.projects.new(project_params)
    bottling_date = params[:project][:bottling_date]
    @project.bottling_date = Date.strptime(bottling_date, "%m/%d/%y")
    
    if @project.save
      redirect_to customer_projects_path(@customer)
    else
      @project.bottling_date = formatted_date(params[:project][:bottling_date])
      render :new, { :project => @project, :customer => @customer }
    end
  end

  def edit
    @project = Project.find(params[:id])
    @project.bottling_date = formatted_date(@project.bottling_date)
    @project.components.build
  end
  
  def update
    @project = Project.find(params[:id])
    date     = params[:project][:bottling_date]
    @project.update_attributes(project_params)
    @project.bottling_date = Date.strptime(date, DATE_FORMAT_STRING) if date
    if @project.save
      respond_to do |wants|
        wants.html { redirect_to project_path(@project) }
        wants.js { @component = params[:model], @requirement = "#{@component}_requirement".intern }
        wants.json { respond_with_bip @project }
      end
    else
      @project.bottling_date = params[:project][:bottling_date]
      render action: :edit
    end
  end

  def add_components
    @project     = Project.find(params[:id])
    model_hash  = params[:project]
    model_hash.each do |model, params|
      @model      = model
      @requirement= "#{@model}_requirement".intern
      assoc       = @model.intern
      model_name  = model.singularize.split("_").each { |w| w.capitalize! }.join('').constantize
      model_id    = params[:id]
      component   = model_name.find model_id
      # associate project with component
      @project.update_attribute(assoc, component)
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
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |wants|
      wants.html { redirect_to projects_path }
      wants.js { }
    end
  end
  
  private
  def fetch_by_project_id
    @project = Project.find(params[:project_id])
  end
  
  def project_params
    params.require(:project).permit(:customer_id, :project_number, :brand, :variety, :winemaker, :target_cases, :wine_id,
                                    :bottling_date, :qb_code, :trucker, :cases_to_customer, :fob, :fso2_target, :max_do,
                                    :vintage, :appellation, :taxes, :no_capsule, :notes, :wine_id, :bottler_id,
                                    :bottled_at_id)
  end
end
