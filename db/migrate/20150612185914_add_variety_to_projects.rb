class AddVarietyToProjects < ActiveRecord::Migration
  def change
    add_column  :projects, :variety, :string, index: true
    add_index   :projects, :brand
  end
end
