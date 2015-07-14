class AddActiveToBackLabels < ActiveRecord::Migration
  def change
    add_column :back_labels, :active, :boolean, nil: false, default: true
  end
end
