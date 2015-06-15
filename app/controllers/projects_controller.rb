class ProjectsController < ApplicationController
  before_action :autocomplete_collections, only: [:new, :create, :edit, :update]
  
  def show
  end

  def index
    @projects = Project.includes(:customer).page(params[:page] || 1)
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @project = @customer.projects.build
    @project.wine = Wine.new
  end

  def edit
  end
  
  private
  def autocomplete_collections
    @brands       = Project.all.map(&:brand)
    @varieties    = Wine.all.map(&:variety)
    @appellations = Wine.all.map(&:appellation)
  end
end
