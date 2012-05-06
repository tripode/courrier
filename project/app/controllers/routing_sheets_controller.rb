class RoutingSheetsController < ApplicationController
  
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
    authorize! :create, RoutingSheet
  end
  
  
  
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
    $products= Array.new
    @area= Area.new
    $total=0;
    $number=ActiveRecord::Base.connection.execute("select last_value from routing_sheets_id_seq").first["last_value"]
    @routing_sheet.number=$number.to_i + 1
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
    @routing_sheet.employee_id=current_user.employee.id #Seteo el user logueado
    @routing_sheet.routing_sheet_state_id = 1 # Por defecto el estado es "En Proceso", id: 1
    @routing_sheet.total_amount=$total
    @routing_sheet.number = $number.to_i + 1
    respond_to do |format|
      begin
        RoutingSheet.transaction do
        @routing_sheet.save #Guardo la cabecera
        $products.each do |product| #Guardo los detalles
            @routing_sheet_detail=RoutingSheetDetail.new
            @routing_sheet_detail.routing_sheet_id=@routing_sheet.id
            @routing_sheet_detail.product_id=product.id
          
            @routing_sheet_detail.save
            @new_product_state_id=ProductState.where("state_name='Enviado'").first.id
            product.update_attribute(:product_state_id,  @new_product_state_id)
          end
        end
        format.html { redirect_to @routing_sheet, notice: 'Routing sheet was successfully created.' }
        format.json { render json: @routing_sheet, status: :created, location: @routing_sheet }
      rescue
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
  ## Agrega el producto a la lista, pasando como parametro el codigo de barra el producto
  def add_product
    @bar_code=params[:bar_code]
    @product_state_id=ProductState.where("state_name='No enviado'").first.id
    @product=Product.where("bar_code=? and product_state_id=?",@bar_code, @product_state_id).first
    if !@product.nil?
        #Verifica si el producto ya fue cargado en lalista
      if !$products.include?(@product)
        $products.push(@product)
        $total=$total + 1  
      end
    end
    
    
    respond_to do |format|
      #format.html { redirect_to routing_sheets_url }
      #format.json { head :no_content }
      format.js
    end
  end
  
  ## Elimina el producto de la lista
  def delete_product
    @product=params[:product]
    if $products.include?(@product)
      $products.delete(@product)
    end
    respond_to do |format|
      #format.html { redirect_to routing_sheets_url }
      #format.json { head :no_content }
      format.js
    end
  end
  
end
