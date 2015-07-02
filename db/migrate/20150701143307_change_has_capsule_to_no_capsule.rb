class ChangeHasCapsuleToNoCapsule < ActiveRecord::Migration
  def change
    rename_column :projects, :has_capsule, :no_capsule
  end
end
