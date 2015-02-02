class ChangeColumnCounts < ActiveRecord::Migration
  def change
    rename_column :counts, :in, :quantity
    change_column :counts, :out, :boolean
    add_column :counts, :rate, :integer
    add_column :transactions, :count_id, :integer
  end
end
