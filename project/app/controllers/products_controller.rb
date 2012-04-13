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
    @products = Product.all

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
    $retire_notes = RetireNote.find(:all) #This variable is for the autocomplete
    $receivers = Receiver.find(:all)
    $product_state=ProductState.new
    $item = 0
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
    respond_to do |format|
      if $product.save
        $product=Product.new
        $product.retire_note_id=@retire_note_id
        $product.product_type_id=@product_type_id
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
  #Metodod que retorna el u objecto receiver
  #Busca el receiver con el id del receiver que se le pasa por parametro
  def getReceiver
   @receiver_name=Receiver.where("id=?",params[:id]).first.receiver_name
   @receiver_address=Receiver.where("id=?",params[:id]).first.address
   @city_id=Receiver.where("id=?",params[:id]).first.city_id
   @city_name=City.where("id=?",@city_id).first.name
   @receiver={name: @receiver_name, address:@receiver_address, city_name:@city_name}
   respond_to do |format|
         format.html #need for ajax with html datatype 
         format.json { render json: @receiver }#need for ajax with json datatyp 
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
