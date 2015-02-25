class RemoveGroupFromShows < ActiveRecord::Migration
  def change
    remove_column :shows, :group_id
  end
end
