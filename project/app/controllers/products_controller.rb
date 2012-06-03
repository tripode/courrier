class ProductsController < ApplicationController
  
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
    authorize! :create, Product
  end
  
  
  # GET /products
  # GET /products.json
  def index
   $products = Array.new
   @customers=Customer.all
   @cities=City.all
   $product=Product.new
   $receivers = Receiver.find(:all)
   $addresses=Array.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: $products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    flash[:notice]=""
    @cities = City.all
    
    $product = Product.new
    $products=Array.new
    #Obtengo la lista de notas de retiro para mostrar en el autocom´ete
    #En la lista muestro todas las notas de retiro no procesadas cuya fecha sea hasta 31 dias antes de la fecha actual
    $retire_notes= RetireNote.find(:all, :conditions=> "retire_note_state_id= 2 and date between current_date-31 and current_date")
    $receivers = Receiver.find(:all)
    
    $addresses=Array.new
    $item = 1
      respond_to do |format|
      format.html # new.html.erb
      format.json { render json: $product }
    end
  end

  # GET /products/1/edit
  def edit
    flash[:notice]=""
    @product_state= ProductState.new
    @product = Product.find(params[:id])
    #El producto no puede ser editado si su estado es recibido
    if @product.product_state_id == ProductState.recibido 
      flash[:notice]="Este producto no puede ser editado."
    end
    
  end

  # POST /products
  # POST /products.json
  def create
    flash[:notice]=""
    #Variables para inicializar popin destinatario
    @cities = City.all
    #Variables de la clase
    $product = Product.new(params[:product])
    $product.product_state_id = ProductState.no_enviado #Estado por defecto del producto es No enviado id = 2
    @retire_note_id=$product.retire_note_id
    @product_type_id=$product.product_type_id
    @retire_note=RetireNote.find(@retire_note_id)
    @amount=RetireNote.where(id: @retire_note_id).first.amount
    respond_to do |format|
    begin  
      if $product.save
        $products.push($product)
        $product=Product.new
        #actualiza la amount_processed de nota de retiro
        begin
          @retire_note.update_attribute(:amount_processed, $item)
        rescue
          flash[:notice]="No se pudo actualizar la cantidad de la nota"
        end
        #Controla que se ingreso todos los productos de la nota de retiro
         if ($item.to_i < @amount.to_i)
          $item= $item + 1
          $product.retire_note_id = @retire_note_id
          $product.product_type_id = @product_type_id
          $product.product_state_id = ProductState.no_enviado #ProductState.where("state_name='No enviado'").first.id
          format.js
         else
            $item= 1 #seteo item a 1 para los productos de una nueva nota de retior
            #Cambio de estado la nota de retiro registrado de "En Proceso" a "Procesado"
            begin
              @state_id=RetireNoteState.where("state_name='Procesado'").first.id
              @retire_note.update_attribute(:retire_note_state_id, @state_id)
            rescue
              flash[:notice]="Esta nota se ha procesado con exito."
            end
            $product = Product.new
            #init all--------------
            #Obtengo la lista de notas de retiro para mostrar en el autocom´ete
            #En la lista muestro todas las notas de retiro no procesadas cuya fecha sea hasta 31 dias antes de la fecha actual
            $retire_notes= RetireNote.find(:all, :conditions=> "retire_note_state_id= 2 and date between current_date-31 and current_date")
            $receivers = Receiver.find(:all)
           
            $addresses=Array.new
            $item = 1
            ##----------
            format.js
         end
      else
        #init all--------------
            #Obtengo la lista de notas de retiro para mostrar en el autocom´ete
            #En la lista muestro todas las notas de retiro no procesadas cuya fecha sea hasta 31 dias antes de la fecha actual
            $retire_notes = RetireNote.find(:all, :conditions=> "retire_note_state_id= 2 and date between current_date-31 and current_date")
            $receivers = Receiver.find(:all)
            $product_state = ProductState.new
            $product.product_state_id = ProductState.no_enviado #ProductState.where("state_name='No enviado'").first.id ##Por defecto el estado es "No Enviado"
            
            $addresses=Array.new
            $item = 1
            ##----------
        format.js
      end
    rescue
      flash[:notice]="Atencion!!El codigo ingresado ya fue registrado.."
      format.js
    end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])
    @product_state= ProductState.new
    respond_to do |format|
      begin
        ##Si el estado del producto es Recibido  no se puede actualizar porque
        ## los productos ya se procesaron
        if @product.product_state_id != ProductState.recibido 
          if @product.update_attributes(params[:product])
            flash[:notice]="El producto ha sido actualizado"
          end
        else
          flash[:notice]="El producto no pudo ser actualizado"
        end
         format.js
      rescue
        flash[:notice]="El producto no pudo ser actualizado."
      ensure
        format.js
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @retire_note_id=@product.retire_note_id
    @retire_note=RetireNote.where(id:  @retire_note_id).first
    @amount_processed=@retire_note.amount_processed
    if @product.destroy 
      ##Actualizo la cantidad de productos registrados de la nota de retiro. Se elimino un producto , se resta 1
      @amount_processed=@amount_processed - 1
      @retire_note.update_attribute(:amount_processed, @amount_processed) 
    end
    $products=Product.where(retire_note_id: @retire_note_id)
    @cities= City.all
    respond_to do |format|
      format.js
      #format.html { redirect_to new_product_path }
      #format.json { head :no_content }
    end
  end
  
  #post
  #Metodo que retorna un objecto product_type
  #busca el product_type mediante el id del product_type
  #pasado como parametro
  
  def getProductType
   @product_type_description=ProductType.where(id: params[:id]).first.description
   @product_type={description: @product_type_description}
   respond_to do |format|
         format.html #need for ajax with html datatype 
         format.json { render json: @product_type }#need for ajax with json datatyp 
    end
  end
  
  #post Este metodo se encarga de actualizar la lista de receivers, devuelve la lista
  # para que sea procesada en la  pagina para el autocomplete
  def update_new_receiver
    
    @receiver_added = Receiver.last
    $receivers << @receiver_added
    respond_to do |format|
      format.html
      format.json {render json: $receivers}
    end
  end
  
  
  #post
  #Metodod que retorna un objecto que contiene las direcciones del destinatario
  #Busca las direcciones con el id del destinatario que se le pasa por parametro
  def getReceiverAddress
   
    $addresses= ReceiverAddress.where(receiver_id: params[:id]);
   respond_to do |format|
         format.html #need for ajax with html datatype 
         format.json { render json: $addresses }#need for ajax with json datatyp
    end
  end
  
  #post
  #Metodo que retorna un customer. Procesa el id del customer 
  #que recibe dentro de params. Es invocado via ajax desde el form _product
  def getCustomer
    @customer=Customer.where(id: params[:id]).first
   respond_to do |format|
         format.html #need for ajax with html datatype 
         format.json { render json: @customer }#need for ajax with json datatyp 
    end
  end
  
  #post
  #Metodo que retorna el item correcspondiente al producto que se va a registrar
  def getItem
    @amount=params[:amount]
    @amount_processed=RetireNote.where(id: params[:id]).first.amount_processed
    $item=@amount_processed
    if ($item.to_i < @amount.to_i)
      $item= $item + 1
    end
    @objectItem={item: $item}
    respond_to do |format|
         format.html #need for ajax with html datatype 
         format.json { render json: @objectItem }#need for ajax with json datatyp 
    end
  end
  #post
  #Metodo para buscar los productos de la nota de retiro de retiro si ya existe en la base de datos
  def getListProducts
    $products=Product.where(retire_note_id: params[:id])
    respond_to do |format|
         format.js
    end
  end
  #post
  #Metodo que retorna la ciudad correcspondiente a una direccion
  def getCity
    @city_id=ReceiverAddress.where(id: params[:address_id]).first.city_id
    @city=City.where(id: @city_id).first
    respond_to do |format|
      format.html
      format.json {render json: @city}
    end
  end
  #Metodo post para realizar busquedas de productos
  def search
    @retire_note_number=params[:retire_note_number]
    @customer_id=params[:customer_id]
    @product_type_id=params[:product_type_id]
    @inited_at=params[:inited_at]
    @finished_at=params[:finished_at]
    @receiver_id=params[:receiver_id]
    @city_id=params[:city_id]
    @product_state_id=params[:product_state_id]
    @bar_code=params[:bar_code]
    
   #filtro por las fechas de inicio y fin
    valid_inited_at=/[0-9]{2}-[0-9]{2}-[0-9]{4}/.match(@inited_at)
    valid_finished_at=/[0-9]{2}-[0-9]{2}-[0-9]{4}/.match(@finished_at)
    if(!valid_inited_at.nil? && !valid_finished_at.nil?) 
      @sql=" 1=1 "
      @sql = @sql + " and products.created_at between '" + @inited_at.to_s + "' and '" + @finished_at.to_s + "'"
    
        
        #Si es distinto de nil es un numero
        valid_number=/^\d+$/.match(@retire_note_number)

        if(!valid_number.nil?) 
        
          @retire_note=RetireNote.where(number: @retire_note_number).first
          if (!@retire_note.nil?) 
            @sql = @sql + " and products.retire_note_id=" + @retire_note.id.to_s
          end
        end
        #Si se selecciono algun tipo de producto entonces agrego a la consulta
        valid_product_type_id=/^\d+$/.match(@product_type_id)
        if(!valid_product_type_id.nil?) 
          @sql = @sql + " and products.product_type_id=" + @product_type_id.to_s
        end
        #Si se selecciono algun tipo de estado entonces agrego a la consulta
        valid_product_state_id=/^\d+$/.match(@product_state_id)
        if(!valid_product_state_id.nil?)
          @sql = @sql + " and products.product_state_id=" + @product_state_id.to_s
        end
        
         #Si se selecciono algun destinatario agrego a la consulta
        valid_receiver_id=/^\d+$/.match(@receiver_id)
        if(!valid_receiver_id.nil?) 
         @sql = @sql + " and receiver_id=" + @receiver_id.to_s
        end
        #Si hay codigo de barras agrego a la consulta
        valid_barcode=/^\d+$/.match(@bar_code)
        if(!valid_barcode.nil?) 
          @sql = @sql + " and products.bar_code='" + @bar_code.to_s + "'"
        end
        
        #Si hay cliente agrego a la consulta
        valid_customer_id=/^\d+$/.match(@customer_id)
        if(!valid_customer_id.nil?) 
          $products=Product.joins("inner join retire_notes r on r.id=products.retire_note_id" +
          " inner join customers c on c.id=r.customer_id  where c.id=" + @customer_id.to_s + " and " + @sql)
        else
          $products=Product.where(@sql)
        end  
    else
       $products=Array.new
    end
    respond_to do |format|
      format.js
    end
  end
  
  
  ## Metodo que redirige a la pagina products_by_customer
  def delivery_report
    @product=Product.new
    @details=Array.new
    @customers=Customer.all
    respond_to do |format|
      format.html # products_by_customer.html.erb
      format.json { render json: @products }
    end
  end
  
  #Post method: Este metodo genera el informe para el cliente de los products
  #entregados entre un rango de fecha
  def generate_delivery_report
  
    
    @customer_id=params[:customer_id]
    @inited_at = params[:inited_at]
    @finished_at = params[:finished_at]
    @details= Array.new
    valid_customer_id=/^\d+$/.match(@customer_id)
    valid_inited_at=/[0-9]{2}-[0-9]{2}-[0-9]{4}/.match(@inited_at)
    valid_finished_at=/[0-9]{2}-[0-9]{2}-[0-9]{4}/.match(@finished_at)
    if(!valid_customer_id.nil? and !valid_inited_at.nil? and !valid_finished_at.nil?) 
      #Obtengo todas las hojas de rutas cuya fecha de registro esta entre @inited_at y finished_at
  
      @routing_sheets=RoutingSheet.where("date between ? and ?", @inited_at,@finished_at)
      if(!@routing_sheets.empty? ) 
        #Por cada hoja de ruta obtengo obtengo los detalles
        @routing_sheets.each do |r|
           @details_by_routing_sheet = RoutingSheetDetail.where(routing_sheet_id: r.id)
           if(!@details_by_routing_sheet.empty?) 
              @details_by_routing_sheet.each do |detail|
                #obtengo el producto del detalle
                @product=Product.where(id: detail.product_id).first
                #obtengo la nota de retiro  a la cual pertenece este producto
                @retire_note= RetireNote.where(id: @product.retire_note_id).first
                #obtengo el cliente que hace referencia a esta nota de retiro
                @get_customer_id = @retire_note.customer_id
                 # Si pertenece al cliente requerido al informe, agrego 
                if (@get_customer_id.to_i == @customer_id.to_i) 
                    @details << detail
                end
                
              end
           end
        end
       
      end
    
      @customer=Customer.where(id: @customer_id).first
      @employee=current_user.employee
    end
    ## Comparo si la vista pide un archivo csv o pdf
      if params[:commit]=="Descargar Excel"
         respond_to do |format|
            format.csv do
              create_date=Date.today
              create_date.strftime("%d-%m-%Y") if create_date
              csv_report = DeliveryReportCsv.new(@inited_at,@finished_at,@customer,@employee,@details,@file_path)
              csv_string = csv_report.getCSV
                # envia al browser
              send_data csv_string, 
                        :type => 'text/csv; charset=iso-8859-1; header=present', 
                        :disposition => "attachment; filename=informe_#{@customer.company_name + @customer.last_name + @customer.name + "_" + create_date.to_s}.csv" 
            end
         end
      else  if params[:commit]=="Generar PDF"
           respond_to do |format|
              format.pdf do
                create_date=Date.today
                create_date.strftime("%d-%m-%Y") if create_date
                @file_path = "#{Rails.root}/app/views/reports/informe_#{@customer.company_name  + @customer.last_name  + @customer.name}_#{create_date}.pdf"
                pdf = DeliveryReportPdf.new(@inited_at,@finished_at,@customer,@employee,@details,delivery_report_products_url,root_url,@file_path)
                begin
                  pdf.render_file(@file_path)
                rescue
                  #no se guardo el archivo
                end
                send_data pdf.render, filename: "informe_#{@customer.company_name  + @customer.last_name  + @customer.name}_#{create_date}.pdf",
                                      type: "application/pdf",
                                      disposition: "inline"
              end
           end
        end
      end
  end
   
  ##
  # Envia el pdf al email del cliente
  # 
  def send_email
    @costumer_id = params[:customer_id]
    @file_path = params[:file_path]
    @costumer = Customer.find(@costumer_id)
    EmailSender.eemail(@costumer.email, @file_path).deliver
    respond_to do |format|
      format.html {redirect_to  delivery_report_products_path}
      format.json { head :no_content }
    end
  end
  
  
  ##
  # Este metodo guarda un nuevo receiver
  #
  def save_receiver
    # se limpia los datos y se guarda el nuevo destinatario
    name = params[:receiver_name]
    document = params[:document]
    Receiver.transaction do 
      receiver = Receiver.create(receiver_name: name, document: document );
      
        addresses = []
        params[:addresses].each do |address|
          number = address[0]
          place = address[1][:place]
          city_id = address[1][:city_id]
          address = address[1][:address]
          
          address = ReceiverAddress.create(label: place, address: address, city_id: city_id, receiver_id: receiver.id)
        end
    end
    @object={success: 1}
    respond_to do |format|
      format.html 
      format.json { render json: @object}
    end
    
  end
  
end
