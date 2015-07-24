class AddAncestryToComponentRequirements < ActiveRecord::Migration
  def change
    add_column :component_requirements, :ancestry, :string
    add_index  :component_requirements, :ancestry
  end
end
