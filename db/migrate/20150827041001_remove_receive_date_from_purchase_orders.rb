class RemoveReceiveDateFromPurchaseOrders < ActiveRecord::Migration
  def change
    remove_column :purchase_orders, :receive_date, :datetime
  end
end
