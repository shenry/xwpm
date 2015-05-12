class FirmsController < ApplicationController
  before_filter :get_type

  # GET /firms
  # GET /firms.xml
  def index
    @customers = @klass.page(params[:page] || 1)

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @firms }
    end
  end

  # GET /firms/1
  # GET /firms/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @firm }
    end
  end

  # GET /firms/new
  # GET /firms/new.xml
  def new
    @firm = Firm.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @firm }
    end
  end

  # GET /firms/1/edit
  def edit
  end

  # POST /firms
  # POST /firms.xml
  def create
    @firm = Firm.new(params[:firm])

    respond_to do |wants|
      if @firm.save
        flash[:notice] = 'Firm was successfully created.'
        wants.html { redirect_to(@firm) }
        wants.xml  { render :xml => @firm, :status => :created, :location => @firm }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @firm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /firms/1
  # PUT /firms/1.xml
  def update
    respond_to do |wants|
      if @firm.update_attributes(params[:firm])
        flash[:notice] = 'Firm was successfully updated.'
        wants.html { redirect_to(@firm) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @firm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /firms/1
  # DELETE /firms/1.xml
  def destroy
    @firm.destroy

    respond_to do |wants|
      wants.html { redirect_to(firms_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def get_type
      puts "request is #{request.path.split('/')}"
      resource  = request.path.split('/')[1]
      puts "resource is #{resource.inspect}"
      @klass    = resource.singularize.capitalize.constantize
    end

end
