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
    @routing_sheets = Array.new
    @routing_sheet=RoutingSheet.new
    @area = Area.new
    @routing_states= RoutingSheetState.new
    @employees=Employee.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @routing_sheets }
    end
  end

  # GET /routing_sheets/1
  # GET /routing_sheets/1.json
  def show
    @routing_sheet = RoutingSheet.find(params[:id])
    @routing_sheets_details= RoutingSheetDetail.where("routing_sheet_id=?",params[:id])
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
    @routing_sheets_details=RoutingSheetDetail.where("routing_sheet_id=?",params[:id])
    $products=Array.new
   
    @routing_sheets_details.each do |detail|
      @product=Product.where("id=?", detail.product_id).first
      $products.push(@product)
    end
    $total=$products.length
    puts $total 
    @area= Area.new
  end

  # POST /routing_sheets
  # POST /routing_sheets.json
  def create
  
    @routing_sheet = RoutingSheet.new(params[:routing_sheet])
    @routing_sheet.employee_id=current_user.employee.id #Seteo el user logueado
    @routing_sheet.routing_sheet_state_id = RoutingSheetState.where("state_name='En Proceso'").first.id # Por defecto el estado es "En Proceso", id: 1
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
        format.html { redirect_to @routing_sheet, notice: 'La Hoja de Ruta se guardo con exito.' }
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
      begin
         RoutingSheet.transaction do
           ##Primero elimino los detalles de la hoja de ruta actualizada de la base de datos
           @routing_sheets_details=RoutingSheetDetail.where("routing_sheet_id=?",@routing_sheet.id)
           @routing_sheets_details.each do |detail|
             ##Actaulizo el estado del producto a No enviado porque se elimina el detalle que hace referencia a el
             @product=Product.where("id=?",detail.product_id).first
             @old_product_state_id=ProductState.where("state_name='No enviado'").first.id
             @product.update_attribute(:product_state_id,  @old_product_state_id)
             #Elimino el detalle de la base de datos
             detail.destroy
           end
           
           @routing_sheet.update_attributes(params[:routing_sheet])
           ##Creo los nuevos detalles de la hoja de ruta actualizada e inserto en la base de datos
           $products.each do |product| #guardo los nuevos detalles
             @routing_sheet_detail=RoutingSheetDetail.new
             @routing_sheet_detail.routing_sheet_id=@routing_sheet.id
             @routing_sheet_detail.product_id=product.id
             @routing_sheet_detail.save
            
             @new_product_state_id=ProductState.where("state_name='Enviado'").first.id
             @product=Product.where("id=?",product.id).first
             @product.update_attribute(:product_state_id,  @new_product_state_id)
            
          end
          
          format.html { redirect_to @routing_sheet, notice: 'La Hoja de Ruta se actualizo correctamente.' }
          format.json { head :no_content }
        end
      rescue
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
  
  ## Get Elimina el producto de la lista
  def delete_product
    @product=Product.where("id=?",params[:id]).first
    if $products.include?(@product)
      $products.delete(@product)
      $total = $total - 1
    end
    respond_to do |format|
      #format.html { redirect_to routing_sheets_url }
      #format.json { head :no_content }
      format.js
    end
  end
  
  ## Post search: busca productos pasandole parametros
  def search
    @number=params[:number]
    @employee_id=params[:employee_id]
    @area_id=params[:area_id]
    @state_id=params[:routing_sheet_state_id]
    @date_start=params[:date_start]
    @date_end=params[:date_end]
   
  
    #filtro por las fechas de inicio y fin
    valid_inited_at=/[0-9]{2}-[0-9]{2}-[0-9]{4}/.match(@date_start)
    valid_finished_at=/[0-9]{2}-[0-9]{2}-[0-9]{4}/.match(@date_end)
    
    if (valid_inited_at != nil and valid_finished_at != nil) then
      @sql=" 1=1 "  
      valid_number=/\d+/.match(@number)
      if(valid_number!=nil) then
        @sql = @sql + " and number=" + @number
      end
      valid_employee=/\d+/.match(@employee_id)
      if(valid_employee!=nil) then
        @sql = @sql + "and employee_id=" + @employee_id
      end
      valid_area=/\d+/.match(@area_id)
      if(valid_area!= nil) then
        @sql = @sql + " and area_id=" + @area_id
      end
      valid_state=/\d+/.match(@state_id)
      if(valid_state!= nil) then
        @sql = @sql + " and routing_sheet_state_id=" + @state_id
      end
      
      @sql = @sql + " and date between '" + @date_start + "' and '" + @date_end + "'"
      @routing_sheets= RoutingSheet.where(@sql)
      if(@routing_sheets== nil) then @routing_sheets=Array.new end 
    else
      @routing_sheets=Array.new
    end
    
    @routing_sheet=RoutingSheet.new
    @area = Area.new
    @routing_states= RoutingSheetState.new
    @employees=Employee.all
    respond_to do |format|
      format.js
    end
  end
end
