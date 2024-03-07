class UsersStationsController < ApplicationController
# users_stations_controller.rb
    def create
        user = current_user
        u_id = params[:user_id]
        s_id = params[:id]
        if UsersStation.find_by(user_id: u_id, station_id: s_id).nil?
            @station = UsersStation.new(user_id: u_id, station_id: s_id) 
            @station.save
            redirect_to user_stations_path(u_id)
        else
            flash[:alert] = "You've already added that station."
            redirect_to user_path(user)
        end
    end

    def destroy
        user = current_user
        u_id = params[:user_id]
        s_id = params[:id]
        user_station = UsersStation.find_by(user_id: u_id, station_id: s_id)
        db_station = Station.find(s_id)

        if !db_station.nil? && db_station.flagged?
            # remove station from DB
            Station.find(s_id).destroy
        end

        user_station.destroy

        redirect_to user_stations_path(user.id)
    end

    def users_station_params
        params.require(:users_station).permit(:user_id, :station_id)
      end
      
end