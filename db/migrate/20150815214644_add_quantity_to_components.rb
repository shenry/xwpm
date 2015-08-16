class AddQuantityToComponents < ActiveRecord::Migration
  def change
    add_column :bottles, :quantity, :decimal, precision: 12, scale: 6, nil: false, default: 0
    add_column :capsules, :quantity, :decimal, precision: 12, scale: 6, nil: false, default: 0
    add_column :closures, :quantity, :decimal, precision: 12, scale: 6, nil: false, default: 0
    add_column :front_labels, :quantity, :decimal, precision: 12, scale: 6, nil: false, default: 0
    add_column :back_labels, :quantity, :decimal, precision: 12, scale: 6, nil: false, default: 0
  end
end
