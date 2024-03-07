class NotesMailer < ApplicationMailer

  def new_note_email(user, note, station)
    @user = user
    @note = note
    @station = station

    mail(
        to: @user.email,
        subject: "New note for #{@station.name}"

    )
  end

end
