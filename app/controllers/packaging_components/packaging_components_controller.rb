class PackagingComponentsController < ApplicationController
  before_filter :get_type
  
  def index
    @components = @klass.includes(:vendor).order(:created_at).page(params[:page] || 1)
  end

  def show
    @packaging_component = PackagingComponent.includes(:vendor).find(params[:id])
  end
  
  def new
    @packaging_component = @klass.new
    @vendors = Vendor.order(:name).map { |v| [v.id, v.name] }
  end
  
  def edit
    @packaging_component = PackagingComponent.find(params[:id])
    @packaging_component.attachments.build
    render action: 'new'
  end
  
  def create
    @packaging_component = @klass.new(packaging_component_params)
    puts "packaging_component is a #{@packaging_component.class}"
    if @packaging_component.save
      puts "................"
      puts "now packaging_component is a #{@packaging_component.class}"
      flash[:notice] = "New #{@klass.to_s} successfully created."
      redirect_to action: 'index'
    else
      render action: 'new', :packaging_component => @packaging_component
    end
  end
  
  def update
    @packaging_component  = PackagingComponent.find(params[:id])
    component_class       = @klass.to_s.underscore.downcase.intern
    new_assets            = params[component_class].delete("new_assets")

    if @packaging_component.update_attributes(packaging_component_params)
      if new_assets && !(new_assets.empty?)
        new_assets.each do |asset|
          attachment = @packaging_component.attachments.build
          attachment.asset = asset
          @packaging_component.save
        end
      end
      flash[:notice] = "#{@klass.to_s.titleize} successfully updated."
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
