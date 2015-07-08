class CreateCreateVendorProductsTables < ActiveRecord::Migration
  def change
    create_table :vendor_products, id: false do |t|
      t.integer :vendable_id, index: true
      t.string  :vendable_type, index: true
      t.integer :vendor_id, index: true
      t.timestamps null: false
    end
  end
end
