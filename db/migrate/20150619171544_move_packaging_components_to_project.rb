class MovePackagingComponentsToProject < ActiveRecord::Migration
  def change
    add_column  :projects, :closure_id,     :integer
    add_column  :projects, :bottle_id,      :integer
    add_column  :projects, :capsule_id,     :integer
    add_column  :projects, :front_label_id, :integer
    add_column  :projects, :back_label_id,  :integer
    add_column  :projects, :shipper_id,     :integer
    
    add_index   :projects, :closure_id
    add_index   :projects, :bottle_id
    add_index   :projects, :capsule_id
    add_index   :projects, :front_label_id
    add_index   :projects, :back_label_id
    add_index   :projects, :shipper_id
  end
end
