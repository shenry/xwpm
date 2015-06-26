class BottlesController < PackagingComponentsController
  
  private
  def packaging_component_params
    params.require(:bottle).permit(:mould, :shape, :fill_point, :fill_point_units, :bottle_capacity, :bottle_capacity_units,
                                   :item_identifier, :vendor_id, :height, :width, :color, :units, :image, :remote_image_url, 
                                   :case_capacity, :carton_size, :case_weight, :pallet_configuration, :new_assets => {}, 
                                   attachments_attributes: [:id, :parent_id, :parent_type, :_destroy, :title, :description])
  end
end