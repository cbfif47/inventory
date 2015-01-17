class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.boolean :available
      t.boolean :active
      
      t.timestamps null: false
    end
  end
end
