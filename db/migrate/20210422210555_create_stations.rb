class CreateStations < ActiveRecord::Migration[6.1]
  def change
    create_table :stations do |t|
      t.string :name
      t.string :address
      t.string :zip
      t.string :status
      t.string :access
      t.boolean :updates, default: false
      t.boolean :flagged, default: false
      #Outlet_Types
      t.boolean :NEMA1450, default: false
      t.boolean :NEMA515, default: false
      t.boolean :NEMA520, default: false
      t.boolean :J1772, default: false
      t.boolean :J1772combo, default: false
      t.boolean :CHADEMO , default: false
      t.boolean :TESLA , default: false
      #Fuel_Types
      t.boolean :BD, default: false
      t.boolean :CNG, default: false
      t.boolean :ELEC, default: false
      t.boolean :E85, default: false
      t.boolean :HY, default: false
      t.boolean :LNG, default: false
      t.boolean :LPG, default: false
      t.timestamps
    end
  end
end
