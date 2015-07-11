class CleanOldForeignKeysFromTables < ActiveRecord::Migration
  def change
    drop_table :packages
    remove_column :projects, :bottle_id, :integer
    remove_column :projects, :closure_id, :integer
    remove_column :projects, :capsule_id, :integer
    remove_column :projects, :front_label_id, :integer
    remove_column :projects, :back_label_id, :integer
  end
end
