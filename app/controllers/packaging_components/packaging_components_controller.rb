class PackagingComponentsController < ApplicationController
  before_filter :get_type
  # respond_to :html, :json
  
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
      render :new
    end
  end
  
  def update
    @component = @klass.find(params[:id]) 
    puts "updating component....."   
    respond_to do |wants|
      if @component.update_attributes(component_params)
        puts "here we are"
        wants.json { respond_with_bip @component }
      else
        puts "errors are #{@component.errors.inspect}"
        # TODO
      end
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
