class CreateCounts < ActiveRecord::Migration
  def change
    create_table :counts do |t|
      t.references :show, index: true
      t.references :item, index: true
      t.integer :in
      t.integer :out

      t.timestamps
    end
    add_column :shows, :group_id, :integer
  end
end
