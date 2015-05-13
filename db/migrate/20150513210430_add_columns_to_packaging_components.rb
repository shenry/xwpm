class AddColumnsToPackagingComponents < ActiveRecord::Migration
  def change
    add_column  :packaging_components, :label_rewind,    :string
    add_column  :packaging_components, :label_treatment, :string
    add_column  :packaging_components, :label_cut,       :string
    add_column  :packaging_components, :label_position,  :string
  end
end
