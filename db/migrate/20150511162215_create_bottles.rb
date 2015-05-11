class CreateBottles < ActiveRecord::Migration
  def change
    create_table :bottles do |t|
      t.string  :mould
      t.string  :shape
      t.integer :vendor_id, index: true
      t.string  :color
      t.string  :name, null: false, default: ""
      t.string  :description, null: false, default: ""
      t.string  :height
      t.string  :height_units
      t.string  :diameter
      t.string  :diameter_units
      t.string  :fill_point
      t.string  :fill_point_units

      t.timestamps null: false
    end
  end
end
