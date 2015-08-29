class CustomersController < FirmsController
  def show
    @category = params[:category] || "needs"
    @firm     ||= Customer.includes([:needs, :projects, :wine_shipments]).find(params[:id])
    respond_to do |wants|
      wants.html {}
      wants.js {}
    end
  end
end