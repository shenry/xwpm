class AddAasmStateToWines < ActiveRecord::Migration
  def change
    add_column :wines, :aasm_state, :string, index: true
  end
end
