class RemoveCodeFromFirms < ActiveRecord::Migration
  def change
    remove_column :firms, :code, :string
  end
end
