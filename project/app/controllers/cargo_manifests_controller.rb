class CargoManifestsController < ApplicationController
  
  #
  # Antes de hacer cualquier cosa con este controler,
  # se verifica si hay permiso para el usuario logueado
  #
  before_filter :check_permissions
  skip_before_filter :require_no_authentication
  #
  # Llama a este metodo y verifica los permisos que tiene para Employee
  #
  def check_permissions
    authorize! :create, CargoManifest
  end
  
  # GET /cargo_manifests
  # GET /cargo_manifests.json
  def index
    @cargo_manifests = CargoManifest.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cargo_manifests }
    end
  end

  # GET /cargo_manifests/1
  # GET /cargo_manifests/1.json
  def show
    @cargo_manifest = CargoManifest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cargo_manifest }
    end
  end

  # se setean todos los valores necesarios para levantar la ventana new
  # de Manifiesto de carga
  # GET /cargo_manifests/new
  # GET /cargo_manifests/new.json
  def new
    puts 'entro a new'
    @cargo_manifest = CargoManifest.new
    @transport_guides= TransportGuide.where(id: 0)
    @cargo_manifest_detail=CargoManifestDetail.new
#    @transport_guide_details= TransportGuideDetail.all
    @cities= City.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cargo_manifest }
    end
  end

  # GET /cargo_manifests/1/edit
  def edit
    @cargo_manifest = CargoManifest.find(params[:id])
  end

  # POST /cargo_manifests
  # POST /cargo_manifests.json
  def create
    @cargo_manifest = CargoManifest.new(params[:cargo_manifest])

    respond_to do |format|
      if @cargo_manifest.save
        format.html { redirect_to @cargo_manifest, notice: 'Cargo manifest was successfully created.' }
        format.json { render json: @cargo_manifest, status: :created, location: @cargo_manifest }
      else
        format.html { render action: "new" }
        format.json { render json: @cargo_manifest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cargo_manifests/1
  # PUT /cargo_manifests/1.json
  def update
    @cargo_manifest = CargoManifest.find(params[:id])

    respond_to do |format|
      if @cargo_manifest.update_attributes(params[:cargo_manifest])
        format.html { redirect_to @cargo_manifest, notice: 'Cargo manifest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cargo_manifest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cargo_manifests/1
  # DELETE /cargo_manifests/1.json
  def destroy
    @cargo_manifest = CargoManifest.find(params[:id])
    @cargo_manifest.destroy

    respond_to do |format|
      format.html { redirect_to cargo_manifests_url }
      format.json { head :no_content }
    end
  end

  #no esta funcionando!
  def get_transport_guides
    puts 'entro en get_transport_guides'
    origin= params[:origin]
    destiny=params[:destiny]
    @transport_guides=TransportGuide.where("origin_city_id = ? AND destination_city_id = ? AND transport_guide_state_id = ?",origin, destiny, 1)
        respond_to do |format|
              format.js
        end
    end

  
end
