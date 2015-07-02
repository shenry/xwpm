class RenameWineComponentsToComponents < ActiveRecord::Migration
  def change
    rename_table :wine_components, :components
  end
end
