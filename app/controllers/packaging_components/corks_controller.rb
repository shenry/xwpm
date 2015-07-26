class CorksController < PackagingComponentsController
  def new
    @vendor = Vendor.find(params[:vendor_id])
    @component = Cork.new
    @component.vendor = @vendor
  end
  
  private
  
  def component_params
    params.require(:cork).permit(:item_number, :material, :color, :height, :diameter, :units,
                                 :image, :artwork, :artwork_source)
  end
end