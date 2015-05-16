class CapsulesController < PackagingComponentsController
  
  private
  def packaging_component_params
    params.require(:packaging_component).permit(:name, :description, :vendor_id, :height, :width, :color, :units, :material,
                                                :has_artwork, :artwork_source)
  end
end