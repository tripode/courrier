class RetireNoteDetailsController < ApplicationController
  # GET /retire_note_details
  # GET /retire_note_details.json
  def index
    @retire_note_details = RetireNoteDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @retire_note_details }
    end
  end

  # GET /retire_note_details/1
  # GET /retire_note_details/1.json
  def show
    @retire_note_detail = RetireNoteDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @retire_note_detail }
    end
  end

  # GET /retire_note_details/new
  # GET /retire_note_details/new.json
  def new
    @retire_note_detail = RetireNoteDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @retire_note_detail }
    end
  end

  # GET /retire_note_details/1/edit
  def edit
    @retire_note_detail = RetireNoteDetail.find(params[:id])
  end

  # POST /retire_note_details
  # POST /retire_note_details.json
  def create
    @retire_note_detail = RetireNoteDetail.new(params[:retire_note_detail])

    respond_to do |format|
      if @retire_note_detail.save
        format.html { redirect_to @retire_note_detail, notice: 'Retire note detail was successfully created.' }
        format.json { render json: @retire_note_detail, status: :created, location: @retire_note_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @retire_note_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /retire_note_details/1
  # PUT /retire_note_details/1.json
  def update
    @retire_note_detail = RetireNoteDetail.find(params[:id])

    respond_to do |format|
      if @retire_note_detail.update_attributes(params[:retire_note_detail])
        format.html { redirect_to @retire_note_detail, notice: 'Retire note detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @retire_note_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /retire_note_details/1
  # DELETE /retire_note_details/1.json
  def destroy
    @retire_note_detail = RetireNoteDetail.find(params[:id])
    @retire_note_detail.destroy

    respond_to do |format|
      format.html { redirect_to retire_note_details_url }
      format.json { head :no_content }
    end
  end
end
