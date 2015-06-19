class AddNoCapsuleToProjects < ActiveRecord::Migration
  def change
    add_column  :projects, :has_capsule, :boolean, null: false, default: false
  end
end
