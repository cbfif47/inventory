class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :sub
      t.boolean :active

      t.timestamps
    end
  end
end
