class CreateComponentEvents < ActiveRecord::Migration
  def change
    create_table :component_events do |t|
      t.column :packageable_id, :integer
      t.column :packageable_type, :string
      t.column :actionable_id, :integer
      t.column :actionable_type, :string
      t.column :delta, :float
      t.column :user_id, :integer, index: true
    end
    
    add_index :component_events, [:packageable_id, :packageable_type]
    add_index :component_events, [:actionable_id, :actionable_type]
  end
end
