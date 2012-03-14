class RoutingSheetsController < ApplicationController
  # GET /routing_sheets
  # GET /routing_sheets.json
  def index
    @routing_sheets = RoutingSheet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @routing_sheets }
    end
  end

  # GET /routing_sheets/1
  # GET /routing_sheets/1.json
  def show
    @routing_sheet = RoutingSheet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @routing_sheet }
    end
  end

  # GET /routing_sheets/new
  # GET /routing_sheets/new.json
  def new
    @routing_sheet = RoutingSheet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @routing_sheet }
    end
  end

  # GET /routing_sheets/1/edit
  def edit
    @routing_sheet = RoutingSheet.find(params[:id])
  end

  # POST /routing_sheets
  # POST /routing_sheets.json
  def create
    @routing_sheet = RoutingSheet.new(params[:routing_sheet])

    respond_to do |format|
      if @routing_sheet.save
        format.html { redirect_to @routing_sheet, notice: 'Routing sheet was successfully created.' }
        format.json { render json: @routing_sheet, status: :created, location: @routing_sheet }
      else
        format.html { render action: "new" }
        format.json { render json: @routing_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /routing_sheets/1
  # PUT /routing_sheets/1.json
  def update
    @routing_sheet = RoutingSheet.find(params[:id])

    respond_to do |format|
      if @routing_sheet.update_attributes(params[:routing_sheet])
        format.html { redirect_to @routing_sheet, notice: 'Routing sheet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @routing_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routing_sheets/1
  # DELETE /routing_sheets/1.json
  def destroy
    @routing_sheet = RoutingSheet.find(params[:id])
    @routing_sheet.destroy

    respond_to do |format|
      format.html { redirect_to routing_sheets_url }
      format.json { head :no_content }
    end
  end
end
