class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.integer :vendor_id, index: true
      t.string  :number, null: false, default: ""
      t.string  :po_image
      t.string  :bol_image
      t.float   :total
      t.datetime :receive_date
      t.datetime :order_date

      t.timestamps null: false
    end
  end
end
