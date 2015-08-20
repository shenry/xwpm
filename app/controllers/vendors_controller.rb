class VendorsController < FirmsController
  def show
    @firm ||= Vendor.find(params[:id])
    @category = params[:category] || @firm.product_types.first.underscore.downcase.pluralize
    respond_to do |wants|
      wants.html { }
      wants.js { }
    end
  end
end