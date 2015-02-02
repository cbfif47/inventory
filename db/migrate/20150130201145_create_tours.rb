class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.string :name
      t.boolean :current
      t.references :group, index: true

      t.timestamps
    end
  end
end
