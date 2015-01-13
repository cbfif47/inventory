class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.date :date
      t.references :item, index: true
      t.references :action_type, index: true
      t.integer :quantity
      t.integer :loc1
      t.integer :loc2

      t.timestamps
    end
  end
end
