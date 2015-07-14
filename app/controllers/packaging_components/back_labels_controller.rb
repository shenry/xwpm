class BackLabelsController < PackagingComponentsController
  
  def index
    super
    render "packaging_components/index"
  end
  def new
    @component = BackLabel.new
    @component.vendor = Vendor.find(params[:vendor_id])
  end
  
  private
  
  def component_params
    params.require(:back_label).permit(:item_number, :height, :width, :units, :material, :color, :cut, :treatment, 
                                       :rewind, :alc, :upc, :image, :artwork, :position)
  end
end