class PackagingComponentsController < ApplicationController
  before_filter :get_type
  
  def index
    if @klass == Closure
      corks     = Cork.includes(:vendor).order(:created_at)
      screwcaps = Screwcap.includes(:vendor).order(:created_at)
      @components = { :corks => corks, :screwcaps => screwcaps, :head => "Corks" }
    elsif @klass == Label
      front_labels  = FrontLabel.includes(:vendor).order(:created_at)
      back_labels   = BackLabel.includes(:vendor).order(:created_at)
      @components   = { :front_labels => front_labels, :back_labels => back_labels, :head => "Front Labels"}
    else
      @components = @klass.includes(:vendor).order(:created_at).page(params[:page] || 1)
    end
    @components
  end

  def show
    
  end
  
  def new
    @packaging_component = PackagingComponent.new
  end
end
