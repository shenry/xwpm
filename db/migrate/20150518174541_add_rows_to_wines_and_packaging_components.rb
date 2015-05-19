class AddRowsToWinesAndPackagingComponents < ActiveRecord::Migration
  def change
    add_column    :wines,                :cost_per_gallon, :float
    add_column    :firms,                :code,            :string
    remove_column :packaging_components, :name,            :string
    remove_column :packaging_components, :description,     :string
    add_column    :packaging_components, :code,            :string
    add_column    :packaging_components, :brand,           :string
  end
end
