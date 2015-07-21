class AddStatusToWineShipment < ActiveRecord::Migration
  def change
    add_column :wine_shipments, :status, :string
    add_column :wine_shipments, :accepted, :boolean, nil: false, default: false
  end
end
