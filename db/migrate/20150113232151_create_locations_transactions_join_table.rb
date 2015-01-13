class CreateLocationsTransactionsJoinTable < ActiveRecord::Migration
  def self.up
      create_table :locations_transactions, :id => false do |t|
          t.integer :location_id
          t.integer :transaction_id
        end
      
      add_index :locations_transactions, [:location_id, :transaction_id]
  end
  def self.down
      drop_table :locations_transactions
    end
end
