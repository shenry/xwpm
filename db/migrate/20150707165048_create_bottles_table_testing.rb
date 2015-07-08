class CreateBottlesTableTesting < ActiveRecord::Migration
  def change
    create_table :bottles do |t|
      t.integer :vendor_id, index: true
      t.string  :item_number
      t.string  :mould
      t.string  :shape
      t.string  :color
      t.string  :height
      t.string  :diameter
      t.string  :neck_diameter
      t.string  :units
      t.string  :finish
      t.string  :fill_point
      t.integer :capacity
      t.string  :capacity_units
      t.string  :bottles_per_case
      t.string  :case_dimensions
      t.string  :pallet_config
      t.string  :case_weight
      t.string  :image
      t.timestamps null: false
    end
    
    create_table :capsules do |t|
      t.integer :vendor_id, index: true
      t.string  :item_number
      t.string  :height
      t.string  :diameter
      t.string  :units
      t.string  :material
      t.string  :color
      t.boolean :has_artwork, null: false, default: false
      t.string  :image
      t.string  :artwork
      t.timestamps null: false
    end
    
    create_table :closures do |t|
      t.integer :vendor_id, index: true
      t.string  :type
      t.string  :item_number
      t.string  :material
      t.string  :color
      t.string  :height
      t.string  :diameter
      t.string  :units
      t.boolean :has_artwork, null: false, default: false
      t.string  :artwork
      t.string  :image
      t.timestamps null: false
    end
    
    create_table :labels do |t|
      t.integer :vendor_id, index: true
      t.string  :type
      t.string  :item_number
      t.string  :height
      t.string  :width
      t.string  :units
      t.string  :material
      t.string  :alc
      t.string  :upc
      t.string  :rewind
      t.string  :cut
      t.string  :position
      t.string  :treatment
      t.string  :artwork_source
      t.string  :image
      t.string  :artwork
      t.timestamps null: false
    end
  end
end
