class FrontLabelsController < PackagingComponentsController  
  def new
    @vendor = Vendor.find(params[:vendor_id])
    @component = FrontLabel.new
    @component.vendor = @vendor
  end
  
  private
  
  def component_params
    params.require(:front_label).permit(:item_number, :height, :width, :units, :material, :alc, :upc,
                                        :rewind, :cut, :position, :treatment, :artwork_source, :image,
                                        :artwork, :artwork_source)
  end
end