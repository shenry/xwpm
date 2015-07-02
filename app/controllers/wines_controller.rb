class WinesController < ApplicationController
  
  def index
    @wines = Wine.includes(:projects).order("sample_number DESC").page(params[:page] || 1)
  end
  
  def show
    @wine = Wine.find(params[:id])
    @wine.components.build
  end
  
  def new
    @wine = Wine.new
  end
  
  def create
    @wine = Wine.new(wine_params)
    if @wine.save
      redirect_to action: :index
    else
      render new_wine_path(@wine)
    end
  end
  
  def edit
    @wine = Wine.find(params[:id])
  end
  
  def update
    @wine = Wine.find(params[:id])
    @wine.update_attributes(wine_params)
    if @wine.save
      redirect_to action: :index
    else
      render edit_wine_path(@wine)
    end
  end
  
  
  private
  def wine_params
    params.require(:wine).permit(:name, :description, :appellation, :variety, :vintage, :alc, :winemaker, 
                                 :sample_number, :treatments, :vinx2_reference)
  end
end
