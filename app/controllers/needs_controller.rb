class NeedsController < ApplicationController
  before_action :fetch_customer
  # def index
  #   @needs = Customer.find(params[:customer_id]).needs.order("created_at DESC").page params[:page]
  # end
  
  def show
    @need = @customer.needs.find(params[:id])
  end
  
  def new
    @need = @customer.needs.build
  end
  
  def create
    @need = @customer.needs.build(needs_params)
    if @need.save
      redirect_to customer_path @customer
    end
  end
  
  private
  
  def fetch_customer
    @customer = Customer.includes(:needs).find(params[:customer_id])
  end
  
  def needs_params
    params.require(:need).permit(
    :appellation,
    :vintage,
    :variety,
    :cases,
    :budget,
    :notes
    )
  end
end
