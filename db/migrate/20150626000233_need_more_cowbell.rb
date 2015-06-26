class NeedMoreCowbell < ActiveRecord::Migration
  def change
    add_column :projects, :trucker, :string
    add_column :projects, :cases_to_customer, :integer, null: false, default: 0
  end
end
