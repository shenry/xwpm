class SeparateLabelsTables < ActiveRecord::Migration
  def change
    rename_table :labels, :front_labels
    remove_column :front_labels, :type, :string
    
    create_table :back_labels do |t|
      t.integer :vendor_id, index: true
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
