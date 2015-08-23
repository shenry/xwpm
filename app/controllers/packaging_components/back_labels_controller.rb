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
  
  def fetch_component
    @component = BackLabel.find(params[:back_label_id])
  end
  
  def component_params
    params.require(:back_label).permit(:item_number, :height, :width, :units, :material, :color, :cut, :treatment, 
                                       :rewind, :alc, :upc, :image, :artwork, :position, :artwork_source)
  end
end