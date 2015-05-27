class Fuck < ActiveRecord::Migration
  def change
    add_column :packaging_components, :documents, :json
  end
end
