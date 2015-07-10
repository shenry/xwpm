class CapsulesController < PackagingComponentsController
  def new
    @vendor = Vendor.find(params[:vendor_id])
    @component = Capsule.new
    @component.vendor = @vendor
  end
  
  private
  
  def component_params
    params.require(:capsule).permit(:item_number, :height, :diameter, :units, :color, :image, :material,
                                    :has_artwork, :artwork)
  end
end