class CustomersController < ApplicationController
  
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
  
  
  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.find(:all, :conditions => "customer_type_id = 2")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers }
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer }
    end
  end 

  # GET /customers/new
  # GET /customers/new.json
  def new
    @customer = Customer.new
    @customer_types = Customer.find(:all, :conditions => "customer_type_id = 2")
    @customers = Customer.find(:all, :conditions => "customer_type_id = 2")
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
    @customer_types = CustomerType.all
    respond_to do |format|
      # format.html { render action: "index" }
      format.js
      # format.json { render json: @customer }
    end
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(params[:customer])
    @customer.customer_type_id = 2
    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'El cliente ha sido correctamente guardado' }
        format.json { render json: @customer, status: :created, location: @customer }
      else
        format.html { redirect_to @customer, notice: 'No se pudo guardar el cliente' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to @customer, notice: 'El cliente ha sido actualizado' }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    respond_to do |format|  
      if  (!RetireNote.exists?(:customer_id => @customer.id) && !TransportGuide.exists?(:customer_id => @customer.id))
        @customer.destroy
        format.html { redirect_to new_customer_path,  notice: 'El cliente ha sido eliminado.' }
        format.json { head :no_content }
      else
        format.html {redirect_to new_customer_path,  notice: 'El cliente no puede ser eliminado' }
        format.json {head :no_content }
      end
    end
  end
  
   
end
