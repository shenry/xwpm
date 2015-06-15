class MoveWinemakerToProject < ActiveRecord::Migration
  def change
    remove_column :wines, :winemaker, :string
    remove_column :wines, :name, :string
    remove_column :wines, :description, :string
    add_column    :projects, :winemaker, :string
    add_column    :wines, :treatments, :text
    add_column    :wines, :description, :text
    
    add_index     :projects, :project_number, unique: true
    add_index     :wines, :sample_number, unique: true
  end
end
