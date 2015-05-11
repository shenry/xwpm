# class CustomersController < ApplicationController
# end

class CustomersController < ApplicationController
  before_filter :find_customer, :only => [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.xml
  def index
    @customers = Customer.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @customers }
    end
  end

  # GET /customers/1
  # GET /customers/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.xml
  def new
    @customer = Customer.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @customer }
    end
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.xml
  def create
    @customer = Customer.new(params[:customer])

    respond_to do |wants|
      if @customer.save
        flash[:notice] = 'Customer was successfully created.'
        wants.html { redirect_to(@customer) }
        wants.xml  { render :xml => @customer, :status => :created, :location => @customer }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.xml
  def update
    respond_to do |wants|
      if @customer.update_attributes(params[:customer])
        flash[:notice] = 'Customer was successfully updated.'
        wants.html { redirect_to(@customer) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.xml
  def destroy
    @customer.destroy

    respond_to do |wants|
      wants.html { redirect_to(customers_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_customer
      @customer = Customer.find(params[:id])
    end
    
    def customer_params
      
    end

end
