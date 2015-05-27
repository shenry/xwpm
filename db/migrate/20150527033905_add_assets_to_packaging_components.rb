class AddAssetsToPackagingComponents < ActiveRecord::Migration
  def change
    # remove_column :packaging_components, :assets, :string
    # add_column    :packaging_components, :assets, :json
  end
end
