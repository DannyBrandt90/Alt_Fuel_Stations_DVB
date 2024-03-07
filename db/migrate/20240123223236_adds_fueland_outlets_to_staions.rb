class AddsFuelandOutletsToStaions < ActiveRecord::Migration[6.1]
  def change
    add_column :stations, :fuel_type_code, :string
    add_column :stations, :outlets, :text
  end
end
