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
   @products = Product.where("retire_note_id=?", 14)
  puts "entor index"
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
    #Obtengo la lista de notas de retiro para mostrar en el autocom´ete
    #En la lista muestro todas las notas de retiro no procesadas cuya fecha sea hasta 30 dias antes de la fecha actual
    $retire_notes= RetireNote.find(:all, :conditions=> "retire_note_state_id= 2 and date between current_date-20 and current_date")
    $receivers = Receiver.find(:all)
    $product_state=ProductState.new
    $product.product_state_id= ProductState.where("state_name='No enviado'").first.id ##Por defecto el estado es "No Enviado"
    @addresses=Array.new
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
    
    @amount=RetireNote.where("id=?",@retire_note_id).first.amount
    respond_to do |format|
      if $product.save
        $product=Product.new
        #Controla que se ingreso todos los productos de la nota de retiro
         if ($item.to_i < @amount.to_i)
          $item= $item + 1
          $product.retire_note_id=@retire_note_id
          $product.product_type_id=@product_type_id
         else
            $item= 1 #seteo item a 1 para los productos de una nueva nota de retior
            #Redirijo la pagina hacia el index para ver todos los productos registrados
            @products = Product.where("retire_note_id=?", @retire_note_id)
            #Cambio de estado la nota de retiro registrado de "En Proceso" a "Procesado"
            begin
              @retire_note=RetireNote.find(@retire_note_id)
              @state_id=RetireNoteState.where("state_name='Procesado'").first.id
              @retire_note.update_attribute(:retire_note_state_id, @state_id)
              puts "actualizo"
            rescue
              puts "no actualizo"
            end
            format.html { render action: "index" }
            format.json { render json: @products }
         end
        
        $product.product_state_id= ProductState.where("state_name='No enviado'").first.id
        
        format.html {render action: "new"}# { redirect_to $product, notice: 'Product was successfully created.' }
        format.json {render json: $product}
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
   
   @addresses= ReceiverAddress.where("receiver_id=",params[:id]);
   @selector="<label>Direccion:</label>"+
              "<select id='product_receiver_address_id'>"+
              "<option value='1'>Direccion 1</option> "+
              "<option value='2'>Direccion 2</option>"+
              "</select>"
   @html_object={html:@selector}
   respond_to do |format|
         format.html #need for ajax with html datatype 
         format.json { render json: @html_object }#need for ajax with json datatyp 
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
    if ($item.to_i < @amount.to_i)
      $item= $item + 1
    end
    @objectItem={item: $item}
    respond_to do |format|
         format.html #need for ajax with html datatype 
         format.json { render json: @objectItem }#need for ajax with json datatyp 
    end
  end
end
