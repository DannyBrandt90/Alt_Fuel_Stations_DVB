module  NotesNotifier
    extend ActiveSupport::Concern

    included do 
        after_action :notify_users, only: [:create]
    end

    private

    def notify_users 
        if @note.persisted?
            puts "Sending Notes email"

            users = @station.users.where.not(id: @note.user_id)
            
            users.each do |user|
                NotesMailer.new_note_email(user, @note, @station).deliver_later
            end
        end
    end
end