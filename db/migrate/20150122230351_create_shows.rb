class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.date :date
      t.string :venue

      t.timestamps
    end
  end
end
