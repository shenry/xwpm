class AddBusinessIdToProjects < ActiveRecord::Migration
  def change
    add_column  :projects,  :customer_id,  :integer, index: true
    add_column  :projects,  :bottler_id,   :integer, index: true
    add_column  :projects,  :bottling_facility_id, :integer, index: true
  end
end
