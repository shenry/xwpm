class AlterVendorProductsTable < ActiveRecord::Migration
  def change
    drop_table :vendor_products
    
    create_table :vendor_products do |t|
      t.integer :vendable_id, index: true
      t.string  :vendable_type, index: true
      t.integer :vendor_id, index: true
      t.timestamps null: false
    end
  end
end
