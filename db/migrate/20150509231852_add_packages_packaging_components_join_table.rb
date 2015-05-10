class AddPackagesPackagingComponentsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :packages, :packaging_tables do |t|
      t.integer :package_id, index: true
      t.integer :packaging_component_id, index: true
    end
  end
end
