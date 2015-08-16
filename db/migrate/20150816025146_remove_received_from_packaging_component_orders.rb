class RemoveReceivedFromPackagingComponentOrders < ActiveRecord::Migration
  def change
    remove_column :packaging_component_orders, :received, :boolean
    add_column    :packaging_component_orders, :aasm_state, :string, index: true
  end
end
