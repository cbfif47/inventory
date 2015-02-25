class AddNotesToShows < ActiveRecord::Migration
  def change
    add_column :shows, :notes, :text
  end
end
