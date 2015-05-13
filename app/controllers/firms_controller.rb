class FirmsController < ApplicationController
  before_filter :get_type

  # GET /firms
  # GET /firms.xml
  def index
    if @klass == Customer
      @firms = @klass.includes(:projects).order(:name).page(params[:page] || 1)
    else
      @firms = @klass.order(:name).page(params[:page] || 1)
    end

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
    @firm = @klass.new

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
    @firm = @klass.new(firm_params)
    @firm.type = @klass.to_s
    puts "@firm = #{@firm.inspect}"

    if @firm.save
      flash[:notice] = 'You did it!'
      redirect_to action: 'index'
    else
      render action: 'new', :firm => @firm
    end

    # respond_to do |wants|
    #   if @firm.save
    #     flash[:notice] = 'Firm was successfully created.'
    #     wants.html { redirect_to(@firm) }
    #     wants.xml  { render :xml => @firm, :status => :created, :location => @firm }
    #   else
    #     wants.html { render :action => "new" }
    #     wants.xml  { render :xml => @firm.errors, :status => :unprocessable_entity }
    #   end
    # end
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
      resource  = request.path.split('/')[1]
      @klass    = resource.singularize.capitalize.constantize
    end
    
    def firm_params
      params[:customer].permit(:name, :contact_name, :contact_email, :contact_phone, :address_line_1, :address_line_2, :city, :state, :zip)
    end

end
