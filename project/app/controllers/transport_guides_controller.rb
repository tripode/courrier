class TransportGuidesController < ApplicationController
  # GET /transport_guides
  # GET /transport_guides.json
  def index
    @transport_guides = TransportGuide.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transport_guides }
    end
  end

  # GET /transport_guides/1
  # GET /transport_guides/1.json
  def show
    @transport_guide = TransportGuide.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transport_guide }
    end
  end

  # GET /transport_guides/new
  # GET /transport_guides/new.json
  def new
    @transport_guide = TransportGuide.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transport_guide }
    end
  end

  # GET /transport_guides/1/edit
  def edit
    @transport_guide = TransportGuide.find(params[:id])
  end

  # POST /transport_guides
  # POST /transport_guides.json
  def create
    @transport_guide = TransportGuide.new(params[:transport_guide])

    respond_to do |format|
      if @transport_guide.save
        format.html { redirect_to @transport_guide, notice: 'Transport guide was successfully created.' }
        format.json { render json: @transport_guide, status: :created, location: @transport_guide }
      else
        format.html { render action: "new" }
        format.json { render json: @transport_guide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transport_guides/1
  # PUT /transport_guides/1.json
  def update
    @transport_guide = TransportGuide.find(params[:id])

    respond_to do |format|
      if @transport_guide.update_attributes(params[:transport_guide])
        format.html { redirect_to @transport_guide, notice: 'Transport guide was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transport_guide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transport_guides/1
  # DELETE /transport_guides/1.json
  def destroy
    @transport_guide = TransportGuide.find(params[:id])
    @transport_guide.destroy

    respond_to do |format|
      format.html { redirect_to transport_guides_url }
      format.json { head :no_content }
    end
  end
end