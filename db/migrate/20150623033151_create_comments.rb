class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer   :project_id,  index: true
      t.integer   :author_id,   index: true
      t.text      :body,        null: false, default: ""
      t.boolean   :actionable,  null: false, default: false
      t.boolean   :resolved,    null: false, default: false
      t.integer   :resolver_id, index: true
      t.datetime  :resolved_at
      
      t.timestamps null: false
    end
  end
end
