class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name

      t.timestamps
    end
    add_column :items, :group_id, :integer
    add_column :prerolls, :group_id, :integer
    add_column :locations, :group_id, :integer
    add_column :transactions, :group_id, :integer
    add_column :users, :group_id, :integer
  end
end
