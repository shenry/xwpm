class AddCogsToComponents < ActiveRecord::Migration
  def change
    add_column :components, :cogs, :float
  end
end
