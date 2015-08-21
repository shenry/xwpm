class AddAasmToPackagingComponents < ActiveRecord::Migration
  PACKAGING_COMPONENTS = [:bottles, :capsules, :closures, :front_labels, :back_labels]
  def change
    PACKAGING_COMPONENTS.each do |table|
      remove_column table, :active, :boolean
      add_column table, :aasm_state, :string, index: true
    end
  end
end
