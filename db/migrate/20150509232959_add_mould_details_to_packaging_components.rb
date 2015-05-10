class AddMouldDetailsToPackagingComponents < ActiveRecord::Migration
  def change
    change_table :packaging_components do |t|
      t.string  :mould
      t.string  :shape
    end
  end
end
