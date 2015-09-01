class AddVolumeUnitsToNeeds < ActiveRecord::Migration
  def change
    add_column :needs, :cases, :string
  end
end
