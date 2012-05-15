class ReceiversController < ApplicationController
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
    authorize! :create, Customer
  end
  
  # GET /receivers
  # GET /receivers.json
  def index
    @receivers = Receiver.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @receivers }
    end
  end

  # GET /receivers/1
  # GET /receivers/1.json
  def show
    @receiver = Receiver.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @receiver }
    end
  end

  # GET /receivers/new
  # GET /receivers/new.json
  def new
    @receiver = Receiver.new
    @receivers = Receiver.all
    @cities = City.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @receiver }
    end
  end

  # GET /receivers/1/edit
  def edit
    @receiver = Receiver.find(params[:id])
    @cities = City.all
    respond_to do |format|
      format.js
    end
  end

  # POST /receivers
  # POST /receivers.json
  def create
    puts params.to_yaml
    @receiver = Receiver.new(:receiver_name => params[:receiver][:receiver_name], :document => params[:receiver][:document])
    respond_to do |format|
      if @receiver.save
        @receiver_addresses = params[:receiver][:receiver_addresses_attributes]
        @receiver_addresses.each do |address|
          ReceiverAddress.create(:receiver_id => @receiver.id, 
                                 :label => address[1][:label],
                                 :address => address[1][:address],
                                 :city_id => address[1][:city_id])  
        end
        flash[:notice] = "guardado."
        if params[:from][:products]
          #redirect to products via js
          format.js {}
        else
          format.html { redirect_to @receiver, algo: flash[:notice]}
          format.json { render json: @receiver, status: :created, location: @receiver }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @receiver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /receivers/1
  # PUT /receivers/1.json
  def update
    @receiver = Receiver.find(params[:id])
    @receiver.receiver_addresses.destroy_all
    respond_to do |format|
      if @receiver.update_attributes(params[:receiver])
        format.html { redirect_to @receiver, notice: 'Receiver was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @receiver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receivers/1
  # DELETE /receivers/1.json
  def destroy
    @receiver = Receiver.find(params[:id])
    @receiver.destroy

    respond_to do |format|
      format.html { redirect_to receivers_url }
      format.json { head :no_content }
    end
  end
  
  ##
  # This method get a ReceiveAddress and put
  # it in a hash of an existing instance of @receiver
  #
  def add_address
    
    params[:place]
    address = ReceiverAddress.new(:label    => params[:place], 
                                  :city_id  => params[:city_id], 
                                  :address  => params[:address])
    @receive.document = "234"
    @receiver.receiver_addresses << address
    respond_to do |format|
      format.html { render @receiver, action ='new'}
    end
  end
  
  
  
  
end
