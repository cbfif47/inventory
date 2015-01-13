class RenameActionTypesTableToActions < ActiveRecord::Migration
  def change
      rename_table :action_types, :actions
  end
end
