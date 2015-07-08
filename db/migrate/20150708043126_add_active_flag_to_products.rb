class AddActiveFlagToProducts < ActiveRecord::Migration
  def change
    add_column  :bottles, :active, :boolean, nil: false, default: true, index: true
    add_column  :capsules,:active, :boolean, nil: false, default: true, index: true
    add_column  :closures,:active, :boolean, nil: false, default: true, index: true
    add_column  :labels,  :active, :boolean, nil: false, default: true, index: true 
  end
end
