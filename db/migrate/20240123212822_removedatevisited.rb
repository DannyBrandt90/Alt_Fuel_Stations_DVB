class Removedatevisited < ActiveRecord::Migration[6.1]
  def change
    remove_column :users_stations, :date_visited, :string
  end
end
