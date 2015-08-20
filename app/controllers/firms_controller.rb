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
    # association = @klass.primary_association
    # TODO - this isn't working for Wineries. Need to get a named association that uses OR (merge joins with AND)
    @firm       = @klass.find(params[:id])
    @associated_collection = []
    # objects     = @firm.send(association)
    # if association == :products
    #   types       = objects.collect(&:vendable_type).uniq
    #   @associated_collection = Hash.new
    #   types.each do |type|
    #     products     = objects.select { |o| o.vendable_type == type }
    #     vendable_ids = products.map(&:vendable_id)
    #     vendables    = type.constantize.where(id: vendable_ids)
    #     @associated_collection[type] = vendables
    #   end
    # else
    #   @associated_collection = objects
    # end
    respond_to do |wants|
      wants.html { }
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
    @firm = @klass.find(params[:id])
  end
  
  def update_firm_attribute
    @firm = Firm.find(params[:firm_id])
    param = params[:attr]
    value = params[:value]
    @firm.update_attributes({param.intern => value})
    if @firm.save
      respond_to do |wants|
        wants.js
      end
    end
  end

  # POST /firms
  # POST /firms.xml
  def create
    @firm = @klass.new(firm_params)
    @firm.type = @klass.to_s

    if @firm.save
      flash[:notice] = "New #{@klass.to_s.downcase} successfully created."
      redirect_to action: 'index'
    else
      render action: 'new', :firm => @firm
    end
  end

  # PUT /firms/1
  # PUT /firms/1.xml
  def update
    respond_to do |wants|
      @firm = @klass.find(params[:id])
      if @firm.update_attributes(firm_params)
        flash[:notice] = "#{@klass.to_s} was successfully updated."
        wants.html { redirect_to controller: @klass.to_s.titleize.downcase.pluralize, action: "index" }
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
    @firm = Firm.find(params[:id])
    @firm.destroy

    respond_to do |wants|
      wants.html { redirect_to(firms_url) }
      wants.js  { }
    end
  end

  private
    # def get_type
    #   resource  = request.path.split('/')[1]
    #   @klass    = resource.singularize.capitalize.constantize
    # end
    
    def firm_params
      klass = @klass.to_s.downcase.intern
      params[klass].permit(:name, :description, :contact_name, :contact_email, :bond, :contact_phone, :address_line_1, :address_line_2, :city, :state, :zip)
    end

end
