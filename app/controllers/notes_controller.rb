class NotesController < ApplicationController
    include NotesNotifier

    def create
        @station= Station.find(params[:station_id])
        @note = Note.new(content: params[:content], user_id: current_user.id, station_id: params[:station_id])
        @note.save
        redirect_to station_path(@station)
    end

    def destroy
        note = Note.find(params[:id])
        station = Station.find(note.station_id)
        note.destroy
        redirect_to station_path(station)
    end

end