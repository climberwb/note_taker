class NotesController < ApplicationController
    before_action :find_note, only: [:show, :edit, :update, :destroy]
    def index
        @notes = Note.where(:user_id=> current_user.id).order("created_at DESC")
    end
    
    def show
    end
    
    def create
        @note = current_user.notes.build(note_params)
        if @note.save
            redirect_to @note
        else
            render 'new'
        end
    end
    
    def new
        @note = current_user.notes.build
    end
    def edit
        
    end
    
    def update
        if find_note.update_attributes(note_params)
            redirect_to find_note
        else
            render 'edit'
        end
    end
    
    def destroy
        if find_note.destroy
            redirect_to notes_path
        else
            render 'edit'
        end
    end
    
    private
    
    def find_note
        @note=Note.find(params[:id])
    end
    
    def note_params
        params.require(:note).permit(:title,:content)
    end
    
end
