class DropAndRebuildPackagingComponents < ActiveRecord::Migration
  def up
    drop_table :packaging_components
    
    create_table :packaging_components do |t|
      t.string  :type, index: true
      t.integer :vendor_id, index: true
      t.string  :mould
      t.string  :shape
      t.string  :color
      t.string  :height
      t.string  :width
      t.string  :depth
      t.string  :fill_point
      t.string  :fill_point_units
      t.string  :neck_diameter
      t.string  :neck_diamter_units
      t.string  :material
      t.boolean :has_artwork
      t.string  :capacity
      t.string  :capacity_units
      t.string  :label_alc
      t.string  :upc
      t.string  :closure_type, index: true
      t.string  :artwork_source
      t.string  :label_type, index: true
      t.string  :units
      t.string  :label_rewind
      t.string  :label_treatment
      t.string  :label_cut
      t.string  :label_position
      t.string  :code
      t.string  :brand
      t.string  :item_identifier
      t.string  :image
      
      t.timestamps
    end
    
  end
  
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
