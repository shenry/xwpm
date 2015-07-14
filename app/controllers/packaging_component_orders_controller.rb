class PackagingComponentOrdersController < ApplicationController
  
  def create
    @purchase_order = PurchaseOrder.find(params[:packaging_component_order][:purchase_order_id])
    @line_item      = @purchase_order.line_items.build(line_item_params)
    @line_item.save
  end
  
  def update
    @line_item = PackagingComponentOrder.find(params[:id])
    @line_item.update_attributes(line_item_params)
  end
  
  # def receive
  #   @line_item  = PackagingComponentOrder.find_by_component_requirement_id(params[:id])
  #   @line_item.update_attributes(received: params[:received])
  # end
  
  
  private
  def line_item_params
    params.require(:packaging_component_order).permit(:component_requirement_id, :purchase_order_id, :quantity, :price,
                                                      :received)
  end
end