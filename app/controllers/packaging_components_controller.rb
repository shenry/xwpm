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
    puts "why are we here?"
  end
  
  def new
    @packaging_component = PackagingComponent.new
    @vendors = Vendor.order(:name).map { |v| [v.id, v.name] }
  end
  
  def create
    @packaging_component = @klass.new(packaging_component_params)
    
    if @packaging_component.save
      flash[:notice] = "New #{@klass.to_s} successfully created."
      redirect_to action: 'index'
    else
      render action: 'new', :packaging_component => @packaging_component
    end
  end
  
  def destroy
    packaging_component = @klass.find(params[:id])
    puts "packaging_component = #{packaging_component.inspect}"
    
    packaging_component.destroy
    redirect_to action: :index
  end
end
