class PackagingComponentsController < ApplicationController
  before_filter :get_type
  
  def index
    @components = @klass.includes(:vendor).order(:created_at).page(params[:page] || 1)
  end

  def show
    @packaging_component = PackagingComponent.includes(:vendor).find(params[:id])
  end
  
  def new
    @packaging_component = PackagingComponent.new
    @vendors = Vendor.order(:name).map { |v| [v.id, v.name] }
  end
  
  def edit
    @packaging_component = PackagingComponent.find(params[:id])
    render action: 'new'
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
  
  def update
    @packaging_component = PackagingComponent.find(params[:id])
    puts "current_images = #{@packaging_component.assets.inspect}"
    puts "params = #{params.inspect}"
    if @packaging_component.update_attributes(packaging_component_params)
      flash[:notice] = "#{@klass.to_s} successfully updated."
      redirect_to action: 'index'
    else
      render action: 'new', :packaging_component => @packaging_component
    end
  end
  
  def destroy
    packaging_component = @klass.find(params[:id])
    
    packaging_component.destroy
    redirect_to action: :index
  end
end
