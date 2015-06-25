class AddClosureTypeToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :closure_type, :string
  end
end
