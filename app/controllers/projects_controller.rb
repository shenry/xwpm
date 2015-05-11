class ProjectsController < ApplicationController
  def show
  end

  def index
    @projects = Project.page(params[:page] || 1)
  end

  def new
  end

  def edit
  end
end
