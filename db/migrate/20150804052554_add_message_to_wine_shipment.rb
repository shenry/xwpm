class AddMessageToWineShipment < ActiveRecord::Migration
  def change
    add_column :wine_shipments, :message, :string
  end
end
