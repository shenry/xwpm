class CreateShippers < ActiveRecord::Migration
  def change
    create_table :shippers do |t|
      t.integer :vendor_id, index: true
      t.string  :name, null: false, default: ""
      t.string  :description, null: false, default: ""
      t.boolean :has_artwork, null: false, default: false
      t.integer :bottle_capacity
      t.string  :height
      t.string  :height_units
      t.string  :width
      t.string  :width_units
      t.string  :depth
      t.string  :depth_units
      t.string  :treatments

      t.timestamps null: false
    end
  end
end
