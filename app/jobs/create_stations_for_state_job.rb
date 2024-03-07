class CreateStationsForStateJob < ApplicationJob
  queue_as :default

  def perform(user_id)
     ActiveRecord::Base.clear_active_connections!
    user = User.find_by(id: user_id)
    return unless user

    if user.state.present? && Station.where(state: user.state).empty?
      puts "Fetching stations in the state"
      ApiController.create_station_objects(user.state, ApiController.get_stations_from_state(user.state))
    else
      puts "State already in DB"
    end
  end
end
