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
      format.json { render json: @products }
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
   
    $product = Product.new
    $products=Array.new
    #Obtengo la lista de notas de retiro para mostrar en el autocom´ete
    #En la lista muestro todas las notas de retiro no procesadas cuya fecha sea hasta 30 dias antes de la fecha actual
    $retire_notes= RetireNote.find(:all, :conditions=> "retire_note_state_id= 2 and date between current_date-20 and current_date")
    $receivers = Receiver.find(:all)
    $product_state=ProductState.new
    $product.product_state_id= ProductState.where("state_name='No enviado'").first.id ##Por defecto el estado es "No Enviado"
    
    $addresses=Array.new
    $item = 1
      respond_to do |format|
      format.html # new.html.erb
      format.json { render json: $product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    $product = Product.new(params[:product])
    @retire_note_id=$product.retire_note_id
    @product_type_id=$product.product_type_id
    @retire_note=RetireNote.find(@retire_note_id)
    @amount=RetireNote.where("id=?",@retire_note_id).first.amount
    respond_to do |format|
      if $product.save
        $products.push($product)
        $product=Product.new
        #actualiza la amount_processed de nota de retiro
        begin
          @retire_note.update_attribute(:amount_processed, $item)
        rescue
          
        end
        #Controla que se ingreso todos los productos de la nota de retiro
         if ($item.to_i < @amount.to_i)
          $item= $item + 1
          $product.retire_note_id=@retire_note_id
          $product.product_type_id=@product_type_id
          $product.product_state_id= ProductState.where("state_name='No enviado'").first.id
          puts "js redireccion"
          format.js
         else
            $item= 1 #seteo item a 1 para los productos de una nueva nota de retior
            #$products = Product.where("retire_note_id=?", @retire_note_id)
            #Cambio de estado la nota de retiro registrado de "En Proceso" a "Procesado"
            begin
              @state_id=RetireNoteState.where("state_name='Procesado'").first.id
              @retire_note.update_attribute(:retire_note_state_id, @state_id)
            rescue
            end
            $product = Product.new
            #init all--------------
            #$products=Array.new
            #Obtengo la lista de notas de retiro para mostrar en el autocom´ete
            #En la lista muestro todas las notas de retiro no procesadas cuya fecha sea hasta 30 dias antes de la fecha actual
            $retire_notes= RetireNote.find(:all, :conditions=> "retire_note_state_id= 2 and date between current_date-20 and current_date")
            $receivers = Receiver.find(:all)
            $product_state=ProductState.new
            $product.product_state_id= ProductState.where("state_name='No enviado'").first.id ##Por defecto el estado es "No Enviado"
            
            $addresses=Array.new
            $item = 1
            ##----------
     
            format.js
            #format.html { render action: "new" }
            #format.json { head :no_content }
         end
        
       
        
        #format.html {render action: "new"}# { redirect_to $product, notice: 'Product was successfully created.' }
        #format.json {render json: $product}
        
        #format.json { render json: $product, status: :created, location: $product }
      else
        format.html { render action: "new" }
        format.json { render json: $product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
  
  #post
  #Metodo que retorna un objecto product_type
  #busca el product_type mediante el id del product_type
  #pasado como parametro
  
  def getProductType
   @product_type_description=ProductType.where("id=?",params[:id]).first.description
   @product_type={description: @product_type_description}
   respond_to do |format|
         format.html #need for ajax with html datatype 
         format.json { render json: @product_type }#need for ajax with json datatyp 
    end
  end
  
  #post
  #Metodod que retorna un objecto que contiene las direcciones del destinatario
  #Busca las direcciones con el id del destinatario que se le pasa por parametro
  def getReceiverAddress
   
    $addresses= ReceiverAddress.where("receiver_id=?",params[:id]);
   respond_to do |format|
         format.html #need for ajax with html datatype 
         format.json { render json: $addresses }#need for ajax with json datatyp
         #format.js 
    end
  end
  
  #post
  #Metodo que retorna un customer. Procesa el id del customer 
  #que recibe dentro de params. Es invocado via ajax desde el form _product
  def getCustomer
    @customer=Customer.where("id=?",params[:id]).first
   respond_to do |format|
         format.html #need for ajax with html datatype 
         format.json { render json: @customer }#need for ajax with json datatyp 
    end
  end
  
  #post
  #Metodo que retorna el item correcspondiente al producto que se va a registrar
  def getItem
    @amount=params[:amount]
    @amount_processed=RetireNote.where("id=?",params[:id]).first.amount_processed
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
    @retire_note_id=params[:id]
    $products=Product.where("retire_note_id=?",@retire_note_id)
    respond_to do |format|
         format.js
    end
  end
  #post
  #Metodo que retorna la ciudad correcspondiente a una direccion
  def getCity
    @city_id=ReceiverAddress.where("id=?",params[:address_id]).first.city_id
    @city=City.where("id=?",@city_id).first
    respond_to do |format|
      format.html
      format.json {render json: @city}
    end
  end
  
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
    if(valid_inited_at != nil && valid_finished_at!= nil) then
      @sql=" 1=1 "
      @sql = @sql + " and products.created_at between '" + @inited_at.to_s + "' and '" + @finished_at.to_s + "'"
    
        
        #Si es distinto de nil es un numero
        valid_number=/\d+/.match(@retire_note_number)
        puts valid_number
        if(valid_number!= nil) then
        
          @retire_note=RetireNote.where("number=?",valid_number.to_s).first
          if (@retire_note!=nil) then
            @sql = @sql + " and products.retire_note_id=" + @retire_note.id.to_s
          end
        end
        #Si se selecciono algun tipo de producto entonces agrego a la consulta
        if(@product_type_id!="") then
          @sql = @sql + " and products.product_type_id=" + @product_type_id.to_s
        end
        #Si se selecciono algun tipo de estado entonces agrego a la consulta
        valid_product_state_id=/\d+/.match(@product_state_id)
        if(valid_product_state_id!=nil)then
          @sql = @sql + " and products.product_state_id=" + valid_product_state_id.to_s
        end
        
         #Si se selecciono algun destinatario agrego a la consulta
        valid_receiver_id=/\d+/.match(@receiver_id)
        if(valid_receiver_id!=nil) then
         @sql = @sql + " and receiver_id=" + valid_receiver_id.to_s
        end
        #Si hay codigo de barras agrego a la consulta
        valid_barcode=/\d+/.match(@bar_code)
        if(valid_barcode!=nil) then
          @sql = @sql + " and products.bar_code='" + valid_barcode.to_s + "'"
        end
        
        #Si hay cliente agrego a la consulta
        valid_customer_id=/\d+/.match(@customer_id)
        puts valid_customer_id
        if(valid_customer_id!=nil) then
          puts "cliente"
          $products=Product.joins("inner join retire_notes r on r.id=products.retire_note_id" +
          " inner join customers c on c.id=r.customer_id  where c.id="+valid_customer_id.to_s + " and " + @sql)
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
end
