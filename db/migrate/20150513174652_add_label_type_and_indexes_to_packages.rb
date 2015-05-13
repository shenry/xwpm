class AddLabelTypeAndIndexesToPackages < ActiveRecord::Migration
  def change
    add_column    :packaging_components, :label_type, :string
    add_column    :packaging_components, :units, :string
    add_index     :packaging_components, :closure_type
    add_index     :packaging_components, :label_type
    remove_column :packaging_components, :height_units, :string
    remove_column :packaging_components, :width_units,  :string
    remove_column :packaging_components, :depth_units,  :string
  end
end
