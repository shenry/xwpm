class CleanUpSchema < ActiveRecord::Migration
  def change
    drop_table :packaging_components
    drop_table :project_events
    
    remove_column :projects, :package_id
    remove_column :projects, :shipper_id
  end
end
