class CustomerCompaniesController < ApplicationController
  
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
  
  
  # GET /customer_companies
  # GET /customer_companies.json
  def index
    @customer_companies = Customer.find(:all, :conditions => "customer_type_id = 1")
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customer_companies }
    end
  end

  # GET /customer_companies/1
  # GET /customer_companies/1.json
  def show
    @customer_company = Customer.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer_company }
    end
  end

  # GET /customer_companies/new
  # GET /customer_companies/new.json
  def new
    @customer_company = Customer.new
    @customer_companies = Customer.find(:all, :conditions => "customer_type_id = 1")
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer_company }
    end
  end

  # GET /customer_companies/1/edit
  def edit
    @customer_company = Customer.find(params[:id])
    @customer_types = CustomerType.all
    respond_to do |format|
      # format.html { render action: "index" }
       format.js 
      # format.json { render json: @customer_company }
    end
  end

  # POST /customer_companies
  # POST /customer_companies.json
  def create
    @customer_company = Customer.new(params[:customer])
    @customer_company.customer_type_id = 1
    respond_to do |format|
      if @customer_company.save
        format.html { redirect_to customer_company_path(@customer_company), notice: 'El cliente ha sido correctamente guardado' }
        format.json { render json: @customer_company, status: :created, location: @customer_company }
      else
       format.html { redirect_to customer_company_path(@customer_company), notice: 'No se ha podido guardar el cliente' }
        format.json { render json: @customer_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customer_companies/1
  # PUT /customer_companies/1.json
  def update
    @customer_company = Customer.find(params[:id])
    respond_to do |format|
      if @customer_company.update_attributes(params[:customer])
        format.html { redirect_to customer_company_path(@customer_company), notice: 'El cliente ha sido actualizado.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_companies/1
  # DELETE /customer_companies/1.json
  def destroy
    @customer_company = Customer.find(params[:id])
    @customer_company.destroy

    respond_to do |format|
      format.html { redirect_to customer_companies_url }
      format.json { head :no_content }
    end
  end
end

