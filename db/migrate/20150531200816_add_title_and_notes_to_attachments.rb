class AddTitleAndNotesToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :title, :string, nil: false, default: ""
    add_column :attachments, :description, :text, nil: false, default: ""
  end
end
