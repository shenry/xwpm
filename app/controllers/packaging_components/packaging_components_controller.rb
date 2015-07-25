class PackagingComponentsController < ApplicationController
  before_filter :get_type
  respond_to :html, :json
  
  def index
    @status      = params[:status] || "active"
    @components  = @klass.send(@status.intern).page params[:page]
  end
  
  def show
    @component = @klass.find(params[:id])
    @projects = @component.projects.active
  end
  
  def create
    vendor = Vendor.find(params[:vendor_id])
    @component = @klass.new(component_params)
    @component.vendor = vendor
    if @component.save
      redirect_to action: :index
    else
      puts "errors on component = #{@component.errors.inspect}"
      render :new
    end
  end
  
  def update
    @component = @klass.find(params[:id])
    
    if @component.update_attributes(component_params)
      respond_with @component
    else
      # TODO
    end
  end
  
  def destroy
    @component = @klass.find(params[:id])
    @component.destroy
    respond_to do |wants|
      wants.html { redirect_to :index }
      wants.js { }
    end
  end
  
end
