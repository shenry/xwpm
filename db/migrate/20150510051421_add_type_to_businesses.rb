class AddTypeToBusinesses < ActiveRecord::Migration
  def change
    add_column  :businesses, :type, :string
  end
end
