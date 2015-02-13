class AddShowIdToTransactions < ActiveRecord::Migration
  def change
    add_reference :transactions, :show, index: true
  end
end
