class DropTablePrerolls < ActiveRecord::Migration
  def change
    drop_table :prerolls
  end
end
