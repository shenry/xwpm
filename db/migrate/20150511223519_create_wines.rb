class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string  :name, null: false, default: ""
      t.string  :description, null: false, default: ""
      t.string  :appellation
      t.string  :appellation_percent
      t.string  :variety
      t.string  :variety_percent
      t.string  :vintage
      t.string  :vintage_percent
      t.string  :alc
      t.string  :winemaker
      t.string  :sample_number

      t.timestamps null: false
    end
  end
end
