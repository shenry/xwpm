class PackagingComponentsController < ApplicationController
  before_filter :get_type
  respond_to :html, :json
  
  def index
    @status   = params[:status] || "active"
    @components  = @klass.send(@status.intern)
  end
  
  def show
    @component = @klass.find(params[:id])
  end
  
  def create
    vendor = Vendor.find(params[:bottle][:vendor_id])
    @component = @klass.new(component_params)
    if @component.save
      @component.vendor = vendor
      redirect_to :index
    else
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
  
end
