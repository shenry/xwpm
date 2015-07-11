class ChangeDiametersToWidth < ActiveRecord::Migration
  def change
    rename_column :bottles, :diameter, :width
    rename_column :capsules, :diameter, :width
    rename_column :closures, :diameter, :width
    
    remove_column :bottles, :vendor_id, :integer
    remove_column :capsules, :vendor_id, :integer
    remove_column :closures, :vendor_id, :integer
    remove_column :labels, :vendor_id, :integer
  end
end
