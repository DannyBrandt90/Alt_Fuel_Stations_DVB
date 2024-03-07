class StationsController < ApplicationController
    include StationNotifier

    def index
        @user = current_user
        @users_stations = UsersStation.where(user_id: current_user.id)
        @stations = @user.stations
        render '/users/users_stations'
    end

    def show 
        @user = current_user
        @station = Station.find_by(id:params[:id])
        @user_count = @station.users.count
        @station_notes = @station.notes
        render '/stations/show'
    end

    def residential
        @user = current_user
        stations =  Station.residential
        @stations =[]
        stations.each do |s|
            if @user.check_settings(s)
                @stations << s
            end
        end
        @message = "Displaying Residential Stations in #{@user.zip}"
        render '/users/show'
    end

    def filter_by_zip
        @user = current_user
        stations =  Station.users_zip(@user.zip)
        @stations =[]
        stations.each do |s|
            if @user.check_settings(s)
                @stations << s
            end
        end
        @message = "Displaying #{@stations.count} Stations in your Zip: #{@user.zip}"
        render '/users/show'
    end

    def filter_by_city
        @user = current_user
        stations =  Station.users_city(@user.city, @user.state)
        @stations =[]
        stations.each do |s|
            if @user.check_settings(s)
                @stations << s
            end
        end
        @message = "Displaying #{@stations.count} Stations in your City: #{@user.city}"
        render '/users/show'
    end

    def filter_by_state
        @user = current_user
        stations =  Station.users_state(@user.state)
        @stations =[]
        stations.each do |s|
            if @user.check_settings(s)
                @stations << s
            end
        end
        @message = "Displaying #{@stations.count} Stations in your State: #{@user.state}"
        render '/users/show'
    end

    def filter
        options = 
        {
            'residential' => method(:residential),
            'filter_by_zip' => method(:filter_by_zip),
            'filter_by_city' => method(:filter_by_city),
            'filter_by_state' => method(:filter_by_state)
        }

        if params[:filter].blank?
            options['filter_by_city'].call
        elsif options[params[:filter]].nil?
            options['filter_by_city'].call
        else
            options[params[:filter]].call
        end
    end

    def new
        @station = Station.new
    end

    def create
        @user = current_user
        @station = @user.stations.build(
            name: params[:station][:name],
            city: params[:station][:city],
            state: params[:station][:state],
            zip: params[:station][:zip],
            address: params[:station][:address],
            phone: params[:station][:phone],
            ELEC: true,
            outlets: [params[:station][:outlets]],
            status: "Pending Approval",
            access: "residential",
            fuel_type_code: "ELEC",
            flagged: true,
            updates: false
        )

        @stations = @user.stations
        
        if @station.save
            render '/users/users_stations'
        else    
           render :new
        end
    end

    def search
        if Station.where(zip: params[:zip])
            @stations = Station.where(zip: params[:zip])
        else
            @stations = ApiController.create_station_objects(params[:zip], ApiController.get_stations_from_zip(params[:zip]))
            render '/stations/search'
    
        end
    end

    def check_for_updates
        user = current_user
        current_stations = Station.where(zip: user.zip)
        new_stations = ApiController.get_stations_from_zip(user.zip)
    
        if current_stations.count != new_stations.count
            if new_stations.count < current_stations.count
                current_stations.each do |station|
                    if !new_stations.select { |s| s['id'] == station.api_id }.any?
                        if station.access == "residential"
                            if station.flagged
                                @message = "#{station.name} Residential Station, is pending approval for public use."
                            else
                                @message = "#{station.name} Residential Station, is available for public use!"
                            end
                        else
                            @message = "#{station.name}, has been removed."
                            station.destroy
                        end
                    end
                end
            elsif new_stations.count > current_stations.count
                new_stations.each do |station|
                    if current_stations.find_by(api_id: station['id']).nil?
                        @message = "#{station['station_name']}, has been added in your area!."
                        ApiController.create_station(station)
                    end
                end
            end
        else
            @message = "No updates in your home zip."
        end
    
        render "/stations/check_for_updates"
    end
    

end