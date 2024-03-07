class NewStationMailer < ApplicationMailer

  def residential_station_email(user, station)
    @user = user
    @station = station

    mail(
        to: "admin@admin.net",
        subject: "#{@user.name} Pending approval for Residential Station"
    )
  end
  
end
