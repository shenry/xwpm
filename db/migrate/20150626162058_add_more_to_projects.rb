class AddMoreToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :fob, :float
    add_column :projects, :taxes, :string
    add_column :projects, :fso2_target, :string
    add_column :projects, :max_do, :string
    
    add_column :wines, :gallons, :integer
    add_column :wines, :vinx2_reference, :string
  end
end
