class CreateCapsules < ActiveRecord::Migration
  def change
    create_table :capsules do |t|
      t.integer :vendor_id, index: true
      t.string  :name, null: false, default: ""
      t.string  :description, null: false, default: ""
      t.string  :color
      t.string  :height
      t.string  :height_units
      t.string  :diameter
      t.string  :diameter_units
      t.boolean :has_artwork, null: false, default: false
      t.string  :material
      t.string  :item_code      

      t.timestamps null: false
    end
  end
end
