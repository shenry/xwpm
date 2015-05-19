class CorksController < PackagingComponentsController
  
  private
  def packaging_component_params
    params.require(:cork).permit(:vendor_id, :name, :item_identifier, :color, :material, :height, :width, :units)
  end
end