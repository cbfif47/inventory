class RemoveGroupFromTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :group_id
  end
end
