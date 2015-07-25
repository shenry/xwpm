class AddItemNumberUniquenessIndexToPackagingComponents < ActiveRecord::Migration
  def change
    add_index :back_labels, :item_number, unique: true
    add_index :bottles, :item_number, unique: true
    add_index :capsules, :item_number, unique: true
    add_index :closures, [:item_number, :type], unique: true
    add_index :front_labels, :item_number, unique: true
  end
end
