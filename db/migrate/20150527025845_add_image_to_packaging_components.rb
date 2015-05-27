class AddImageToPackagingComponents < ActiveRecord::Migration
  def change
    add_column :packaging_components, :image, :string
  end
end
