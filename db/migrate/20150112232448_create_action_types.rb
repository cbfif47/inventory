class CreateActionTypes < ActiveRecord::Migration
  def change
    create_table :action_types do |t|
      t.string :action
      t.integer :impact

      t.timestamps
    end
  end
end
