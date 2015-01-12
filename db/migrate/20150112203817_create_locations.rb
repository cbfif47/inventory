class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.boolean :on_tour
      t.boolean :active

      t.timestamps
    end
  end
end
