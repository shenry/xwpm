class AddShippingToPosAndNotesToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :notes, :text, nil: false, default: ""
    add_column :purchase_orders, :overhead, :float
  end
end
