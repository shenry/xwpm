class ComponentsController < ApplicationController
  def create
    @wine = Wine.find(params[:wine_id])
    @component = @wine.components.new(component_params)
    if @component.save
      @new_component = @wine.components.build
      respond_to do |wants|
        wants.js {}
      end
    end
  end
  
  private
  def component_params
    params.require(:component).permit(:lot_number, :volume, :cogs, :description, :value, :vintage_percent,
                                      :appellation_percent, :variety_percent)
  end
end