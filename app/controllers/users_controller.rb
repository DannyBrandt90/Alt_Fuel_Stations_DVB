require_relative './api_controller.rb'

class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]

    def new
        if user_signed_in?
            redirect_to user_path(current_user)
        else
            @user = User.new
            render :new
        end
    end

    def create
        @user = User.new(user_params)
        # add all fuel types after update to set all are set to default 
        @user.users_fuels = ["ELEC","BD","CNG","E85","HY","LNG","LPG"]

        if @user.save
            session[:user_id] = @user.id

            if !@user.zip.nil?
                if !Station.where(state: @user.state)
                    ApiController.create_station_objects(@user.zip, ApiController.get_stations_from_zip(@user.zip))
                end
            end
            redirect_to user_path(@user), notice: 'User was successfully created.'
        else
            render :new
        end
    end

    def show
        @user = current_user
        if @user.state.nil? 
            @stations = []
            flash.now[:alert] = "Go to settings to set your location."
        else
            if  Station.where(city: @user.city).empty? && Station.where(state: @user.state).empty?
                # load all of the state's stations to DB
                stations = ApiController.create_station_objects(@user.state, ApiController.get_stations_from_state(@user.state))
            elsif !Station.where(city: @user.city)
                flash.now[:alert] = "Unable to Find any stations in your city, please check your spelling in your settings."
            end

            # stations = Station.where(city: @user.city)
            stations = Station.where(zip: @user.zip)


            @stations = []
        
            stations.each do |s|
                if @user.check_settings(s)
                    @stations << s
                end
            end
                
            @stations
        end
    end

    def update
        user = current_user
        email = params[:user][:email]
        password = params[:user][:password]

        if email != ""
            user.update(email: email)
        end
        if password != ""
            user.update(password: password)
        end
        
        redirect_to edit_user_path(user), alert: "User updated"
    end
    
    def destroy
        User.find(current_user.id).destroy
        redirect_to new_user_path
    end

    def settings
        @user = current_user
        render '/users/settings'
    end



    def update_settings
        user = current_user
        user.update(settings_params)

        users_fuels = []
        users_fuels << "BD" if user.BD
        users_fuels << "ELEC" if user.ELEC
        users_fuels << "CNG" if user.CNG
        users_fuels << "LPG" if user.LPG
        users_fuels << "LNG" if user.LNG
        users_fuels << "HY" if user.HY
        users_fuels << "E85" if user.E85
      
        # Update the user's fuel types
        user.update(users_fuels: users_fuels)

        if !Station.where(state: user.state)
            ApiController.create_station_objects(user.state, ApiController.get_stations_from_state(user.state))
        end

        redirect_to user_path(user.id)
    end

    private 

    def user_params
        params.require(:user).permit(:name, :state, :city, :zip, :email, :password)
    end

    def settings_params
        params.require(:user).permit(
            :name,
            :state,
            :city,
            :zip,
            :BD,
            :ELEC,
            :CNG,
            :E85,
            :HY,
            :LNG,
            :LPG,
            :users_fuels
        )

    end
end