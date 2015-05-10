class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer   :package_id, index: true
      t.datetime  :bottling_date
      t.integer   :cases
      t.string    :approved_sample
      t.integer   :wine_id, index: true
      t.integer   

      t.timestamps null: false
    end
  end
end
