class PackagingComponentsController < ApplicationController
  before_filter :get_type
  before_filter :fetch_component, only: [:deactivate, :reactivate]
  # respond_to :html, :json
  
  def index
    @status      = params[:status] || "active"
    @components  = @klass.send(@status.intern).order(:created_at).page params[:page]
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
  
  def deactivate
    respond_to do |wants|
      wants.js {
        event = ComponentEvent::Deactivate.new
        @component.events << event
      }
    end
  end
  
  def reactivate
    respond_to do |wants|
      wants.js {
        event = ComponentEvent::Reactivate.new
        @component.events << event 
      }
    end
  end
  
  def update
    @component = @klass.find(params[:id])
    image     = @component.image
    image_url = image.to_s
    respond_to do |wants|
      if @component.update_attributes(component_params)
        wants.json { respond_with_bip @component }
        wants.js {}
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
