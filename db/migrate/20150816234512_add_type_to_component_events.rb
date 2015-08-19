class AddTypeToComponentEvents < ActiveRecord::Migration
  def change
    add_column :component_events, :type, :string
    add_index :component_events, [:id, :type]
  end
end
