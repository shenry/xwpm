class BottlesController < PackagingComponentsController
  
  private
  def packaging_component_params
    params.require(:bottle).permit(:mould, :shape, :fill_point, :fill_point_units, :capacity, :capacity_units,
                                        :name, :description, :vendor_id, :height, :height_units, :width, :width_units, 
                                        :color, :units)
  end
end