class ChangeOnTourColumnName < ActiveRecord::Migration
  def change
      rename_column :locations, :on_tour, :available
  end
end
