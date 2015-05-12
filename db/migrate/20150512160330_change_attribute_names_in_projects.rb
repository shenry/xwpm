class ChangeAttributeNamesInProjects < ActiveRecord::Migration
  def change
    rename_column :projects, :name, :brand
    add_column    :projects, :bottling_date, :datetime
  end
end
