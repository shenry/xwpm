class CreateProjectEvents < ActiveRecord::Migration
  def change
    create_table :project_events do |t|
      t.belongs_to  :project, index: true
      t.belongs_to  :user,    index: true
      t.string      :state,   index: true
      t.timestamps null: false
    end
  end
end
