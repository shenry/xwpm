class ClosuresController < PackagingComponentsController
  
  private
  def packaging_component_params
    params.require(:packaging_component).permit(:vendor_id, :name, :item_identifier, :color, :material, :height, :width, :units,
                                                :image, :new_assets => {}, attachments_attributes: [:id, :parent_id, :parent_type, 
                                                :_destroy, :title, :description])
  end
end