class CreateWineShipments < ActiveRecord::Migration
  def change
    create_table :wine_shipments do |t|
      t.integer   :customer_id,     index: true
      t.integer   :wine_id,         index: true
      t.string    :tracking_number, index: true, unique: true
      t.datetime  :ship_date
      t.string    :feedback
      t.string    :carrier
      t.boolean   :approved, null: false, default: false
      t.timestamps null: false
    end
  end
end
