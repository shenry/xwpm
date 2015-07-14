class AddPrimaryKeyToComponentOrders < ActiveRecord::Migration
  def change
    # drop_table :packaging_component_orders
    
    create_table :packaging_component_orders do |t|
      t.integer :component_requirement_id
      t.integer :purchase_order_id, index: true
      t.float   :quantity
      t.float   :price
      t.boolean :received, null: false, default: false
    end
    
    add_index :packaging_component_orders, :component_requirement_id, unique: true
  end
end
