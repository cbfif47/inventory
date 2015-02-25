class AddCityToShows < ActiveRecord::Migration
  def change
    add_column :shows, :city, :string
  end
end
