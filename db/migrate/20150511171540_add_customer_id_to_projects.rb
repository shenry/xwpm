class AddCustomerIdToProjects < ActiveRecord::Migration
  def change
    add_column  :projects, :customer_id, :integer
    add_index   :projects, :customer_id
  end
end
