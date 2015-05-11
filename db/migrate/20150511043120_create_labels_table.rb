class CreateLabelsTable < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.integer :vendor_id,   index: true
      t.string  :name,        null: false, default: ""
      t.string  :description, null: false, default: ""
      t.string  :art_source
      t.string  :width
      t.string  :width_units
      t.string  :length
      t.string  :length_units
      t.string  :material
      t.string  :treatment
      t.string  :die_cut
      t.string  :upc
      t.string  :label_alc
      t.string  :type
      
      t.timestamps null: false
    end
  end
end
