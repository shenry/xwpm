class ClosuresController < PackagingComponentsController
  
  private
  def packaging_component_params
    params.require(:packaging_component).permit(:vendor_id, :name, :description, :color, :material, :height, :width, :units)
  end
end