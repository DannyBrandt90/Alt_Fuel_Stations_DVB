# Preview all emails at http://localhost:3000/rails/mailers/new_staion_mailer
class NewStaionMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/new_staion_mailer/residential_station_email
  def residential_station_email
    NewStaionMailer.residential_station_email
  end

end
