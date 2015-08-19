class ChangeQuantitieisToIntegers < ActiveRecord::Migration
  def change
    change_column :bottles, :quantity, :integer
    change_column :capsules, :quantity, :integer
    change_column :closures, :quantity, :integer
    change_column :front_labels, :quantity, :integer
    change_column :back_labels, :quantity, :integer
  end
end
