class RemovePreviousComponentTables < ActiveRecord::Migration
  def change
    drop_table  :bottles
    drop_table  :closures
    drop_table  :labels
    drop_table  :capsules
    drop_table  :shippers
  end
end
