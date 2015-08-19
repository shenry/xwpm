class ChangeLineItemsToReferenceComponents < ActiveRecord::Migration
  def change
    remove_column :packaging_component_orders, :component_requirement_id, :integer
    add_column    :packaging_component_orders, :packageable_id, :integer
    add_column    :packaging_component_orders, :packageable_type, :string
    add_index     :packaging_component_orders, [:packageable_id, :packageable_type], 
                  name: "packaging_component_orders_on_packageable"
  end
end
