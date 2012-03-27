class RetireNotesController < ApplicationController
  # GET /retire_notes
  # GET /retire_notes.json
  def index
    @retire_note = RetireNote.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @retire_note }
    end
  end

  # GET /retire_notes/1
  # GET /retire_notes/1.json
  def show
    @retire_note = RetireNote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @retire_note }
    end
  end

  # GET /retire_notes/new
  # GET /retire_notes/new.json
  def new
    @retire_note = RetireNote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @retire_note }
    end
  end

  # GET /retire_notes/1/edit
  def edit
    @retire_note = RetireNote.find(params[:id])
  end

  # POST /retire_notes
  # POST /retire_notes.json
  def create
    @retire_note = RetireNote.new(params[:retire_note])

    respond_to do |format|
      if @retire_note.save
        format.html { redirect_to @retire_note, notice: 'Retire note was successfully created.' }
        format.json { render json: @retire_note, status: :created, location: @retire_note }
      else
        format.html { render action: "new" }
        format.json { render json: @retire_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /retire_notes/1
  # PUT /retire_notes/1.json
  def update
    @retire_note = RetireNote.find(params[:id])

    respond_to do |format|
      if @retire_note.update_attributes(params[:retire_note])
        format.html { redirect_to @retire_note, notice: 'Retire note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @retire_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /retire_notes/1
  # DELETE /retire_notes/1.json
  def destroy
    @retire_note = RetireNote.find(params[:id])
    @retire_note.destroy

    respond_to do |format|
      format.html { redirect_to retire_notes_url }
      format.json { head :no_content }
    end
  end
end
