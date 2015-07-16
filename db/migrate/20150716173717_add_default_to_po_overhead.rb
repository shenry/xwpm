class AddDefaultToPoOverhead < ActiveRecord::Migration
  def change
    change_column :purchase_orders, :overhead, :float, nil: false, default: 0
    change_column :packaging_component_orders, :price, :float, nil: false, default: 0
    change_column :packaging_component_orders, :quantity, :float, nil: false, default: 0
  end
end
