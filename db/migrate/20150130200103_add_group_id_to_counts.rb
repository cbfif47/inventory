class AddGroupIdToCounts < ActiveRecord::Migration
  def change
    add_reference :counts, :group, index: true
    add_column :items, :soft, :boolean
  end
end
