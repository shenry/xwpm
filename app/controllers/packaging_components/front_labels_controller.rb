class FrontLabelsController < PackagingComponentsController
  def packaging_component_params
    params.require(:front_label).permit(:vendor_id, :height, :width, :units, :label_alc, :upc, :label_rewind,
                                        :label_cut, :label_position, :label_treatment, :item_identifier, :material, :image, 
                                        :artwork_source, :new_assets => {}, attachments_attributes: [:id, :parent_id, 
                                        :parent_type, :_destroy, :title, :description])
  end
end