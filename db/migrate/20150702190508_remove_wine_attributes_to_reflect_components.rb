class RemoveWineAttributesToReflectComponents < ActiveRecord::Migration
  def change
    remove_column :wines, :appellation_percent, :string
    remove_column :wines, :vintage_percent, :string
    remove_column :wines, :variety_percent, :string
    remove_column :wines, :gallons, :integer
    remove_column :wines, :cogs, :float
    
    add_column    :components, :appellation_percent, :float, default: 100.0
    add_column    :components, :vintage_percent, :float, default: 100.0
    add_column    :components, :variety_percent, :float, default: 100.0
    
    remove_column :components, :value, :string
  end
end
