class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string  :name
      t.string  :contact_name
      t.string  :contact_phone
      t.string  :contact_email
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
