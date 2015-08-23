class CapsulesController < PackagingComponentsController
  def new
    @vendor = Vendor.find(params[:vendor_id])
    @component = Capsule.new
    @component.vendor = @vendor
  end
  
  private
  
  def fetch_component
    @component = Capsule.find(params[:capsule_id])
  end
  
  def component_params
    params.require(:capsule).permit(:item_number, :height, :width, :units, :color, :image, :material,
                                    :has_artwork, :artwork, :artwork_source)
  end
end