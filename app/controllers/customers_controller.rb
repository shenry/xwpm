class CustomersController < FirmsController
  def show
    @category = params[:category] || "projects"
    @firm     ||= Customer.find(params[:id])
    respond_to do |wants|
      wants.html {}
      wants.js {}
    end
  end
end