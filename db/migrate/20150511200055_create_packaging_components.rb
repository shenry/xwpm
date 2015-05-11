class CreatePackagingComponents < ActiveRecord::Migration
  def change
    create_table :packaging_components do |t|

      t.timestamps null: false
    end
  end
end
