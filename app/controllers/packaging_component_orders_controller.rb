class PackagingComponentOrdersController < ApplicationController
  # include GlobalID::
  before_action :set_line_item, only: [:receive, :undo]
  
  def create
    @purchase_order = PurchaseOrder.find(params[:packaging_component_order][:purchase_order_id])
    sent_params = line_item_params.dup
    packageable     = sent_params.extract!("packageable")
    @line_item      = @purchase_order.line_items.build(sent_params)
    component = GlobalID::Locator.locate_signed packageable["packageable"]
    @line_item.packageable = component
    @line_item.save
  end
  
  def update
    @line_item = PackagingComponentOrder.find(params[:id])
    @line_item.update_attributes(line_item_params)
  end
  
  def receive
    @line_item.receive!(:received, user: current_user)
    render nothing: true
  end
  
  def undo
    @line_item.undo!
    render nothing: true
  end

  private  
  def set_line_item
    @line_item = PackagingComponentOrder.find(params[:packaging_component_order_id])
  end
  
  def line_item_params
    params.require(:packaging_component_order).permit(:packageable, :purchase_order_id, :quantity, :price, :received)
  end
end