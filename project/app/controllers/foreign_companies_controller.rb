class ForeignCompaniesController < ApplicationController
  # GET /foreign_companies
  # GET /foreign_companies.json
  def index
    @foreign_companies = ForeignCompany.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @foreign_companies }
    end
  end

  # GET /foreign_companies/1
  # GET /foreign_companies/1.json
  def show
    @foreign_company = ForeignCompany.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @foreign_company }
    end
  end

  # GET /foreign_companies/new
  # GET /foreign_companies/new.json
  def new
    @foreign_company = ForeignCompany.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @foreign_company }
    end
  end

  # GET /foreign_companies/1/edit
  def edit
    @foreign_company = ForeignCompany.find(params[:id])
  end

  # POST /foreign_companies
  # POST /foreign_companies.json
  def create
    @foreign_company = ForeignCompany.new(params[:foreign_company])

    respond_to do |format|
      if @foreign_company.save
        format.html { redirect_to @foreign_company, notice: 'Foreign company was successfully created.' }
        format.json { render json: @foreign_company, status: :created, location: @foreign_company }
      else
        format.html { render action: "new" }
        format.json { render json: @foreign_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /foreign_companies/1
  # PUT /foreign_companies/1.json
  def update
    @foreign_company = ForeignCompany.find(params[:id])

    respond_to do |format|
      if @foreign_company.update_attributes(params[:foreign_company])
        format.html { redirect_to @foreign_company, notice: 'Foreign company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @foreign_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foreign_companies/1
  # DELETE /foreign_companies/1.json
  def destroy
    @foreign_company = ForeignCompany.find(params[:id])
    @foreign_company.destroy

    respond_to do |format|
      format.html { redirect_to foreign_companies_url }
      format.json { head :no_content }
    end
  end
end
