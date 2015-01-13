class ChangeActiontypeidName < ActiveRecord::Migration
  def change
      rename_column :transactions, :action_type_id, :action_id
      rename_column :prerolls, :action_type_id, :action_id
  end
end
