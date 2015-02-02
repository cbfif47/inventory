class AddTourIdToShows < ActiveRecord::Migration
  def change
    add_reference :shows, :tour, index: true
  end
end
