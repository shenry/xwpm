class BottlesController < PackagingComponentsController
  def new
    @vendor = Vendor.find(params[:vendor_id])
    @component = Bottle.new
    puts "component vendor is #{@component.vendor.inspect} --- in the controller"
    @component.vendor = @vendor
  end
  
  private
  
  def component_params
    params.require(:bottle).permit(:item_number, :height, :diameter, :units, :mould, :shape, :color,
                                  :finish, :neck_diameter, :fill_point, :capacity, :capacity_units,
                                  :bottles_per_case, :case_dimensions, :case_weight, :pallet_config,
                                  :image, :width)
  end
end