class PurchaseOrdersController < ApplicationController
  def index
    @purchase_orders = PurchaseOrder.open
  end
  
  def show
    @purchase_order = PurchaseOrder.find(params[:id])
    @purchase_order.line_items.build
    @associated_projects = Project.associated_with_vendor(@purchase_order.vendor_id)
  end
  
  def new
    today = Date.today.strftime("%m/%d/%y")
    @purchase_order = PurchaseOrder.new(order_date: today)
    @purchase_order.line_items.build
  end
  
  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)
    if @purchase_order.save
      redirect_to purchase_order_path(@purchase_order)
    else
      
    end
  end
  
  private
  
  def purchase_order_params
    params.require(:purchase_order).permit(:number, :vendor_id, :order_date)
  end
end
