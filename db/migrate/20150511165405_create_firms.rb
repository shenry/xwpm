class CreateFirms < ActiveRecord::Migration
  def change
    create_table :firms do |t|
      t.string  :type
      t.string  :name, null: false, default: ""
      t.string  :description, null: false, default: ""
      t.string  :contact_name
      t.string  :contact_email
      t.string  :contact_phone
      t.string  :address_line_1
      t.string  :address_line_2
      t.string  :city
      t.string  :state
      t.string  :zip
      t.string  :bond
      t.string  :account_number

      t.timestamps null: false
    end
  end
end
