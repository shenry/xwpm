class AddCounterCacheToPurchaseOrders < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :line_items_count, :integer
  end
end
