class AddWineriesToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :bottled_at_id, :integer, index: true
    add_column :projects, :bottler_id, :integer, index: true
  end
end
