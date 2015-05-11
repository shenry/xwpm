class CreatePackagingComponents < ActiveRecord::Migration
  def change
    create_table :packaging_components do |t|
      t.string  :type
      t.string  :name, null: false, default: ""
      t.string  :description, null: false, default: ""
      t.integer :vendor_id, index: true
      t.string  :mould  # Bottle
      t.string  :shape  # Bottle
      t.string  :color  # Bottle, Screwcap, Capsule
      t.string  :height
      t.string  :height_units
      t.string  :width
      t.string  :width_units
      t.string  :depth
      t.string  :depth_units
      t.string  :fill_point
      t.string  :fill_point_units
      t.string  :material
      t.boolean :has_artwork, default: false
      t.string  :capacity
      t.string  :capacity_units

      t.timestamps null: false
    end
  end
end
