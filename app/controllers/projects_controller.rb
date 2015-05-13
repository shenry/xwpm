class ProjectsController < ApplicationController
  def show
  end

  def index
    @projects = Project.includes(:customer).page(params[:page] || 1)
  end

  def new
  end

  def edit
  end
end
