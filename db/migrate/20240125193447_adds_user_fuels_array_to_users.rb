class AddsUserFuelsArrayToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :users_fuels, :text
  end
end
