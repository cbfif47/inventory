class RemoveGroupFromCounts < ActiveRecord::Migration
  def change
    remove_column :counts, :group_id
  end
end
