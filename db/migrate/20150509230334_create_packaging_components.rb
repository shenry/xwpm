class CreatePackagingComponents < ActiveRecord::Migration
  def change
    create_table :packaging_components do |t|
      t.integer :vendor_id, index: true
      t.string  :type
      t.string  :color
      t.string  :art_source
      t.string  :height
      t.string  :height_units
      t.string  :width
      t.string  :width_units
      t.string  :depth
      t.string  :depth_units
      t.string  :weight
      t.string  :weight_units
      t.string  :treatment
      t.string  :die_cut
      t.string  :label_alc

      t.timestamps null: false
    end
  end
end
