class CreateWineComponents < ActiveRecord::Migration
  def change
    create_table :wine_components do |t|
      t.integer :wine_id,     index: true
      t.string  :lot_number,  index: true
      t.integer :volume
      t.string  :description
      t.string  :value
      t.timestamps null: false
    end
  end
end
