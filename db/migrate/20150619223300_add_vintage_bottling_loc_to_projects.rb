class AddVintageBottlingLocToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :vintage, :string
    add_column :projects, :appellation, :string
  end
end
