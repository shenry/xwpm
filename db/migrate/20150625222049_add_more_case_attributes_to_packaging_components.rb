class AddMoreCaseAttributesToPackagingComponents < ActiveRecord::Migration
  def change
    rename_column :packaging_components, :capacity,       :bottle_capacity
    rename_column :packaging_components, :capacity_units, :bottle_capacity_units
    add_column    :packaging_components, :case_capacity,  :string
    add_column    :packaging_components, :carton_size,    :string
    add_column    :packaging_components, :case_weight,    :float
    add_column    :packaging_components, :pallet_configuration, :string
  end
end
