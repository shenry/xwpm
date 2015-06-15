class AddIndexesToWines < ActiveRecord::Migration
  def change
    add_index :wines, :variety
    add_index :wines, :appellation
  end
end
