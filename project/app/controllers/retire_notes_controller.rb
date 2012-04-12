class RetireNotesController < ApplicationController
  
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
    authorize! :create, RetireNote
  end


  # GET /retire_notes
  # GET /retire_notes.json
  def index
   
    @retire_notes= RetireNote.find(:all, :conditions=> "date between current_date-10 and current_date")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @retire_note }
    end
  end

  # GET /retire_notes/1
  # GET /retire_notes/1.json
  def show
    @retire_note = RetireNote.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @retire_note }
    end
  end

  # GET /retire_notes/new
  # GET /retire_notes/new.json
  def new
    puts "entroooooooo"
    @retire_note = RetireNote.new
    @customer = Customer.new
    @customers = Customer.find(:all)
    @employees = Employee.find(:all)
    @retire_notes= RetireNote.find(:all, :conditions=> "date between current_date-10 and current_date")
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @retire_note }
    end
  end

  # GET /retire_notes/1/edit
  def edit
    @retire_note = RetireNote.find(params[:id])
    @customers = Customer.find(:all)
    @employees = Employee.find(:all)
    respond_to do |format|
      # format.html { render action: "index" }
      format.js
      # format.json { render json: @customer }
    end
  end

  # POST /retire_notes
  # POST /retire_notes.json
  def create
    @retire_note = RetireNote.new(params[:retire_note])
    @customers = Customer.find(:all)
    @employees = Employee.find(:all)
    @retire_notes= RetireNote.find(:all, :conditions=> "date between current_date-10 and current_date")
    respond_to do |format|
      if @retire_note.save
        format.html { redirect_to @retire_note, notice: 'Retire note was successfully created.' }
        format.json { render json: @retire_note, status: :created, location: @retire_note }
      else
        format.html { render action: "new" }
        format.json { render json: @retire_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /retire_notes/1
  # PUT /retire_notes/1.json
  def update
    @retire_note = RetireNote.find(params[:id])

    respond_to do |format|
      if @retire_note.update_attributes(params[:retire_note])
        format.html { redirect_to @retire_note, notice: 'Retire note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @retire_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /retire_notes/1
  # DELETE /retire_notes/1.json
  def destroy
    @retire_note = RetireNote.find(params[:id])
    @retire_note.destroy

    respond_to do |format|
      format.html { redirect_to retire_notes_url }
      format.json { head :no_content }
    end
  end
  
  
end
