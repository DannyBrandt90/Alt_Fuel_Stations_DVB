# Preview all emails at http://localhost:3000/rails/mailers/notes_mailer
class NotesMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notes_mailer/new_note_email
  def new_note_email
    user = User.first
    note = Note.last 
    station = Station.first
    NotesMailer.new_note_email(user, note, station)
  end

end
