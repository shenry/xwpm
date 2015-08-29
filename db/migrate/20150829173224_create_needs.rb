class CreateNeeds < ActiveRecord::Migration
  def change
    create_table :needs do |t|
      t.integer :customer_id, index: true
      t.string  :appellation
      t.string  :variety
      t.string  :vintage
      t.string  :budget
      t.string  :notes
      t.timestamps null: false
    end
    
    add_column :projects, :need_id, :integer, index: true
    add_column :wine_shipments, :need_id, :integer, index: true
  end
end
