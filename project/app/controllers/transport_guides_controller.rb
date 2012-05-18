class TransportGuidesController < ApplicationController
  
  
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
    authorize! :create, TransportGuide
  end
  
  
  # GET /transport_guides
  # GET /transport_guides.json
  def index
    #    @transport_guides = TransportGuide.find(:all, :conditions=> "created_at between current_date-10 and current_date")
    @transport_guides= TransportGuide.all
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
    @@cities = City.find(:all)
    @cities = @@cities
    @@customers = Customer.find(:all)
    @customers = @@customers;
    @transport_guide = TransportGuide.new
    @transport_guide_detail=TransportGuideDetail.new
    #    @transport_guide_details = TransportGuideDetail.where(transport_guide_id: @transport_guide.id)
    #mala practica de programación pero lo hago para el metodo js agregarFila_Arreglo
    #no me tire error en el each vere como puedo depurar luego
    @transport_guide_details= TransportGuideDetail.where(transport_guide_id: 0)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transport_guide }
    end
  end

  # GET /transport_guides/1/edit
  def edit
    @cities = City.find(:all)
    @customers = Customer.find(:all)
    @transport_guide_detail=TransportGuideDetail.new
    
    @transport_guide = TransportGuide.find(params[:id])
    @transport_guide_details = TransportGuideDetail.where(transport_guide_id: @transport_guide.id)
    respond_to do |format|
      format.html { render action: "new" }
      #        format.js
      format.json { render json: @transport_guide }
    end
  end

  # POST /transport_guides
  # POST /transport_guides.json
  def create
    begin
      TransportGuide.transaction do

        @transport_guide = TransportGuide.new(params[:transport_guide])
        @transport_guide.save
        params[:details].each do |k,v|
          v[:transport_guide_id] =@transport_guide.id
          @transport_guide_detail =TransportGuideDetail.new(v)
          @transport_guide_detail.save

        end
      end
      respond_to do |format|
        format.html { redirect_to new_transport_guide_path, notice: "Guardado Correctamente!"}
        format.json { head :no_content}
      end
    rescue ActiveRecord::StatementInvalid
      manejo_error_pg(@transport_guide)
    rescue
      respond_to do |format|
        format.html { redirect_to new_transport_guide_path,
                      notice: "Error en la transaccion, no se guardo la Guia de Transporte"}
        format.json { head :no_content}
      end

    end
    
  end


  # PUT /transport_guides/1
  # PUT /transport_guides/1.json
  def update
    @transport_guide = TransportGuide.find(params[:id])
    value=nil
    TransportGuide.transaction do
      value=@transport_guide.update_attributes(params[:transport_guide])
      @transport_guide_details=TransportGuideDetail.where(transport_guide_id: @transport_guide.id)
      @transport_guide_details.each do |item|
        item.destroy
      end
      params[:details].each do |k,v|
        v[:transport_guide_id] =@transport_guide.id
        @transport_guide_detail =TransportGuideDetail.new(v)
        @transport_guide_detail.save
      end
    end

    respond_to do |format|
      if value
        format.html { redirect_to new_transport_guide_path, notice: "GT N&#176#{@transport_guide.num_guide} Actualizado Correctamente!"}
        format.json { head :no_content}
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

  private
  def manejo_error_pg(transport_guide)
    transport_guide.num_guide=''
    @tranport_guide=transport_guide
    @cities = @@cities
    @customers = @@customers
    @transport_guide_detail=TransportGuideDetail.new
    @transport_guide_details = TransportGuideDetail.where(transport_guide_id: 0)
    respond_to do |format| 
        format.html { redirect_to new_transport_guide_path,
                      notice: "ERROR, Numero de Guia de Transporte ingresado ya existe"}
        format.json { head :no_content }
      end
  end


end
