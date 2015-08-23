class WinesController < ApplicationController
  before_filter :autocomplete_collections, only: [:new, :create, :edit, :update]
  
  def index
    @status = params[:status] || "active"
    @wines = Wine.send(@status.intern).includes(:projects).order("sample_number DESC").page(params[:page] || 1)
  end
  
  def show
    @wine = Wine.find(params[:id])
    @wine.components.build
    @customer_options = Customer.select_options
  end
  
  def new
    @wine = Wine.new
  end
  
  def deactivate
    respond_to do |wants|
      wants.js {
        @wine = Wine.find(params[:wine_id])
        @wine.deactivate! 
      }
    end
  end
  
  def reactivate
    respond_to do |wants|
      wants.js {
        @wine = Wine.find(params[:wine_id])
        @wine.reactivate! 
      }
    end
  end
  
  def create
    @wine = Wine.new(wine_params)
    if @wine.save
      redirect_to wine_path(@wine)
    else
      render new_wine_path(@wine)
    end
  end
  
  def edit
    @wine = Wine.find(params[:id])
  end
  
  def update
    @wine = Wine.find(params[:id])
    respond_to do |wants|
      if @wine.update_attributes(wine_params)
        wants.json { respond_with_bip @wine }
      else
        
      end
    end
  end
  
  def destroy
    @wine = Wine.find(params[:id])
    @wine.destroy
    respond_to do |wants|
      wants.html { redirect_to wines_path }
      wants.js { }
    end
  end
  
  
  private
  def wine_params
    params.require(:wine).permit(:description, :appellation, :variety, :vintage, :alc, 
                                 :sample_number, :treatments, :vinx2_reference)
  end
end
