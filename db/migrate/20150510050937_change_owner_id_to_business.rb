class ChangeOwnerIdToBusiness < ActiveRecord::Migration
  # def change
  # end
  def up
    remove_column :packaging_components, :vendor_id, :integer
    add_column    :packaging_components, :business_id, :integer, index: true
  end
  
  def down
    remove_column :packaging_components, :business_id, :integer
    add_column    :packaging_components, :vendor_id, index: true
  end
end
