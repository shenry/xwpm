class ChangePricePerGallonToCogs < ActiveRecord::Migration
  def change
    rename_column :wines, :cost_per_gallon, :cogs
  end
end
