class NeedsController < ApplicationController
  # def index
  #   @needs = Customer.find(params[:customer_id]).needs.order("created_at DESC").page params[:page]
  # end
  
  def new
    @customer = Customer.includes(:needs).find(params[:customer_id])
    @need = @customer.needs.build
  end
end
