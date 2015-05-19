class WinesController < ApplicationController
  
  def index
    @wines = Wine.includes(:projects).order("name ASC, created_at DESC").page(params[:page] || 1)
  end
  
  
  private
  def wine_params
    params.require(:wine).permit(:name, :description, :appellation, :appellation_percent, :variety, :variety_percent,
                                 :vintage, :vintage_percent, :alc, :winemaker, :sample_number)
  end
end
