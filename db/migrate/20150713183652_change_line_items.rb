class ChangeLineItems < ActiveRecord::Migration
  def change
    remove_column :packaging_component_orders, :project_id, :integer
    remove_column :packaging_component_orders, :packaging_component_id, :integer
    
    add_column    :packaging_component_orders, :component_requirement_id, :integer, index: true, unique: true
  end
end
