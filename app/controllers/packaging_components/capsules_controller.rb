class CapsulesController < PackagingComponentsController
  
  private
  def packaging_component_params
    params.require(:capsule).permit(:name, :item_identifier, :vendor_id, :height, :width, :color, :units, :material,
                                                :has_artwork, :artwork_source)
  end
end