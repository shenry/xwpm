class AddMoreColumnsToProjects < ActiveRecord::Migration
  def change
    add_column    :projects, :qb_code,         :string
    add_column    :projects, :project_number,  :string
    add_column    :projects, :target_cases,    :integer
    remove_column :projects, :name
    add_column    :projects, :name, :string, null: false, default: ""
    add_column    :projects, :description, :string, null: false, default: ""
  end
end
