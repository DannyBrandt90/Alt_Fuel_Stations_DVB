module  StationNotifier
    extend ActiveSupport::Concern

    included do 
        after_action :notify_users, only: [:create]
    end

    private

    def notify_users 
        if @station.persisted?
            puts "Sending Residential Station email to Admin"
            NewStationMailer.residential_station_email(@user, @station).deliver_later
        end
    end
end