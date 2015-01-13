class CreatePrerolls < ActiveRecord::Migration
  def change
    create_table :prerolls do |t|
      t.date :date
      t.references :action_type, index: true
      t.integer :loc1
      t.integer :loc2

      t.timestamps
    end
  end
end
