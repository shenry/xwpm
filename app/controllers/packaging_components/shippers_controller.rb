class ShippersController < PackagingComponentsController
  
  def packaging_component_params
    params.require(:shipper).permit(:vendor_id, :name, :width, :height, :depth, :units, :capacity, :capacity_units)
  end
end