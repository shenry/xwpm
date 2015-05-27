class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string      :asset
      t.references  :parent, polymorphic: true

      t.timestamps null: false
    end
    add_index :attachments, [:parent_type, :parent_id]
  end
end
