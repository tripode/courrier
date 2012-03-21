class CustomerCompaniesController < ApplicationController
# GET /customer_companies
  # GET /customer_companies.json
  def index
    @customers = Customer.find(:all, :conditions => "customer_type_id=1")
    @customer = Customer.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers }
    end
  end

  # GET /customer_companies/1
  # GET /customer_companies/1.json
  def show
    @customer = Customer.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customer_companies/new
  # GET /customer_companies/new.json
  def new
    @customer = Customer.new
    @customer_types = CustomerType.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customer_companies/1/edit
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
    @customer.customer_type_id=1
    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'El cliente ha sido correctamente guardado' }
        format.json { render json: @customer, status: :created, location: @customer }
      else
        format.html { render action: "new" }
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
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end
end

