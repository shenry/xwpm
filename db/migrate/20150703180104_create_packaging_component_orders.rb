class CreatePackagingComponentOrders < ActiveRecord::Migration
  def change
    create_table :packaging_component_orders, id: false do |t|
      t.integer :purchase_order_id, index: true
      t.integer :project_id, index: true
      t.integer :packaging_component_id, index: true

      t.timestamps null: false
    end
  end
end
