class AddCounterCacheToProjects < ActiveRecord::Migration
  def change
    add_column :firms, :projects_count, :integer
  end
end
