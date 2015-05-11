class AddRewindToLabels < ActiveRecord::Migration
  def change
    add_column  :labels, :string, :rewind
  end
end
