class ScrewcapsController < PackagingComponentsController
  def new
    @vendor = Vendor.find(params[:vendor_id])
    @component = Screwcap.new
    @component.vendor = @vendor
  end
  
  private
  
  def fetch_component
    @component = Screwcap.find(params[:screwcap_id])
  end
  
  def component_params
    params.require(:screwcap).permit(:item_number, :material, :color, :height, :width, :units, :image,
                                     :artwork, :artwork_source)
  end
end