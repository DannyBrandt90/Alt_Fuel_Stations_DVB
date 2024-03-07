class SetDefaultBooleansInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :BD, from: nil, to: true
    change_column_default :users, :CNG, from: nil, to: true
    change_column_default :users, :ELEC, from: nil, to: true
    change_column_default :users, :E85, from: nil, to: true
    change_column_default :users, :HY, from: nil, to: true
    change_column_default :users, :LNG, from: nil, to: true
    change_column_default :users, :LPG, from: nil, to: true
  end
end
