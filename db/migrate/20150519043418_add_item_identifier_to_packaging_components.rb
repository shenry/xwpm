class AddItemIdentifierToPackagingComponents < ActiveRecord::Migration
  def change
    add_column :packaging_components, :item_identifier, :string, null: false, default: ""
  end
end
