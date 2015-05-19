class ShippersController < PackagingComponentsController
  
  def packaging_component_params
    params.require(:shipper).permit(:vendor_id, :name, :item_identifier, :width, :height, :depth, :units, :capacity, :capacity_units)
  end
end