class RountingSheetsController < ApplicationController
  # GET /rounting_sheets
  # GET /rounting_sheets.json
  def index
    @rounting_sheets = RountingSheet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rounting_sheets }
    end
  end

  # GET /rounting_sheets/1
  # GET /rounting_sheets/1.json
  def show
    @rounting_sheet = RountingSheet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rounting_sheet }
    end
  end

  # GET /rounting_sheets/new
  # GET /rounting_sheets/new.json
  def new
    @rounting_sheet = RountingSheet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rounting_sheet }
    end
  end

  # GET /rounting_sheets/1/edit
  def edit
    @rounting_sheet = RountingSheet.find(params[:id])
  end

  # POST /rounting_sheets
  # POST /rounting_sheets.json
  def create
    @rounting_sheet = RountingSheet.new(params[:rounting_sheet])

    respond_to do |format|
      if @rounting_sheet.save
        format.html { redirect_to @rounting_sheet, notice: 'Rounting sheet was successfully created.' }
        format.json { render json: @rounting_sheet, status: :created, location: @rounting_sheet }
      else
        format.html { render action: "new" }
        format.json { render json: @rounting_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rounting_sheets/1
  # PUT /rounting_sheets/1.json
  def update
    @rounting_sheet = RountingSheet.find(params[:id])

    respond_to do |format|
      if @rounting_sheet.update_attributes(params[:rounting_sheet])
        format.html { redirect_to @rounting_sheet, notice: 'Rounting sheet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rounting_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rounting_sheets/1
  # DELETE /rounting_sheets/1.json
  def destroy
    @rounting_sheet = RountingSheet.find(params[:id])
    @rounting_sheet.destroy

    respond_to do |format|
      format.html { redirect_to rounting_sheets_url }
      format.json { head :no_content }
    end
  end
end
