class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.integer :plus
      t.string :special
      t.belongs_to :show, index: true

      t.timestamps
    end
  end
end
