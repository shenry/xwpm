class AddRewindToLabels < ActiveRecord::Migration
  def change
    add_column  :labels, :rewind, :string
  end
end
