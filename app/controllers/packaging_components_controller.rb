class PackagingComponentsController < ApplicationController
  before_filter :get_type
  
  def index
    if @klass == Closure
      corks     = Cork.includes(:vendor).order(:created_at)
      screwcaps = Screwcap.includes(:vendor).order(:created_at)
      @components = {:corks => corks, :screwcaps => screwcaps}
    else
      @components = @klass.includes(:vendor).order(:created_at).page(params[:page] || 1)
    end
    @components
  end

end
