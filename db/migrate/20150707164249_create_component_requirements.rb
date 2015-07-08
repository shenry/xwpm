class CreateComponentRequirements < ActiveRecord::Migration
  def change
    create_table :component_requirements do |t|
      t.integer :project_id, index: true
      t.integer :packageable_id, index: true
      t.string :packageable_type, index: true

      t.timestamps null: false
    end
  end
end
