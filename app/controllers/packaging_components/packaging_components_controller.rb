class PackagingComponentsController < ApplicationController
  before_filter :get_type
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
  
  def update
    @component = @klass.find(params[:id])
    filtered   = component_params.dup
    state      = filtered.extract!("state")
    if state
      if state["state"] == "active"
        event = ComponentEvent::Reactivate.new
      elsif state["state"] == "inactive"
        event = ComponentEvent::Deactivate.new
      else; raise "Unknown PackagingComponent State"
      end
      @component.events << event
    end
    image     = @component.image
    image_url = image.to_s
    respond_to do |wants|
      if @component.update_attributes(filtered)
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
