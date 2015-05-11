class CreateProjectsPackagesAndComponents < ActiveRecord::Migration
  def change
    create_table  :projects do |t|
      t.string  :name
      t.integer :package_id,  index: true
      t.integer :wine_id,     index: true
      
      t.timestamps null: false
    end
    
    create_table  :packages do |t|
      t.string  :name,            null: false, default: ""
      t.string  :description,     null: false, default: ""
      t.integer :closure_id,      index: true
      t.integer :bottle_id,       index: true
      t.integer :front_label_id,  index: true
      t.integer :back_label_id,   index: true
      t.integer :capsule_id,      index: true
      t.integer :shipper_id,      index: true
      
      t.timestamps null: false
    end
    
    create_table  :closures do |t|
      t.string  :type,        index: true
      t.integer :vendor_id,   index: true
      t.string  :name,        null: false, default: ""
      t.string  :description, null: false, default: ""
      t.string  :color
      t.boolean :has_artwork, default: false
      t.string  :material
      t.string  :height
      t.string  :height_units
      t.string  :diameter
      t.string  :diameter_units
      
      t.timestamps null: false
    end
  end
end
