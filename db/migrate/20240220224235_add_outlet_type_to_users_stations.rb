class AddOutletTypeToUsersStations < ActiveRecord::Migration[6.1]
  def change
    add_column :users_stations, :outlet_type, :string
  end
end
