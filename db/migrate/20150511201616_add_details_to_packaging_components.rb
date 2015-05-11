class AddDetailsToPackagingComponents < ActiveRecord::Migration
  def change
    add_column  :packaging_components, :label_alc,      :string
    add_column  :packaging_components, :upc,            :string
    add_column  :packaging_components, :closure_type,   :string
    add_column  :packaging_components, :artwork_source, :string
    add_index   :packaging_components, :type
  end
end
