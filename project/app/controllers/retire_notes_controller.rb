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
    @retire_note=RetireNote.new
    @retire_note.employee_id=current_user.employee.id
    @customer = Customer.new
    @customers = Customer.find(:all)
    @employees = Employee.find(:all)
    @retire_notes=Array.new
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
      format.json { render json: @retire_note}
    
    end
  end

  # GET /retire_notes/new
  # GET /retire_notes/new.json
  def new
    @retire_note = RetireNote.new
    @retire_note.employee_id=current_user.employee.id
    @customer = Customer.new
    @customers = Customer.find(:all)
    @employees = Employee.find(:all)
    #En la lista muestro todas las notas de retiro no procesadas cuya fecha sea hasta 30 dias antes de la fecha actual
    @retire_notes= RetireNote.find(:all, :conditions=> "retire_note_state_id= 2 and date between current_date-20 and current_date")
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
    @retire_note.employee_id=current_user.employee.id
    @retire_note.retire_note_state_id=RetireNoteState.where("state_name='En Proceso'").first.id
    respond_to do |format|
      begin
          if @retire_note.save
            format.html { redirect_to new_retire_note_path, notice: 'La nota de retiro ha sido guardada..' }
            format.json { head :no_content}
          else
            format.html { redirect_to @retire_note, notice: 'No se pudo guardar la nota de retiro..' }
            format.json {  head :no_content }
          end
      rescue
         format.html { redirect_to @retire_note, notice: 'Error al intentar guardar la nota de retiro..' }
         format.json {  head :no_content }
      end
      
    end
  end

  # PUT /retire_notes/1
  # PUT /retire_notes/1.json
  def update
    @retire_note = RetireNote.find(params[:id])

    respond_to do |format|
      begin
          if @retire_note.update_attributes(params[:retire_note])
            format.html { redirect_to new_retire_note_path, notice: 'La nota de retiro ha sido actualizada..' }
            format.json { head :no_content }
          else
            format.html { redirect_to new_retire_note_path, notice: 'No se pudo actualizar la nota de retiro..' }
            format.json {  head :no_content }
          end
      rescue
         format.html { redirect_to new_retire_note_path, notice: 'Error al intentar actualizar la nota de retiro..' }
         format.json {  head :no_content }
      end
    end
  end

  # DELETE /retire_notes/1
  # DELETE /retire_notes/1.json
  def destroy
    @retire_note = RetireNote.find(params[:id])
    @notice=""

    respond_to do |format|
      begin
        @retire_note.destroy
        @notice="La nota de retiro ha sido eliminada.."
      rescue
        @notice="Esta nota de retiro no puede ser eliminada.."
      ensure
       format.html { redirect_to new_retire_note_path, notice: @notice }
       format.json { head :no_content } 
      end
    end
  end
  
  
  # SEARCH post hace una consulta a la base de datos con los parametros que recibe del cliente
  def search
    @retire_notes=Array.new
     @retire_note=RetireNote.new # inicializo para usar metodos de formato de fecha que tiene nota de retiro
     @customers = Customer.find(:all) #necesito para el autocomplite
     @sql="1=1"
     #Obtengo los parametros para la consulta
     @number=params[:number]
     @customer_id=params[:customer_id]
     @register_date=params[:date]
     @expiration_date=params[:expiration_date]
     @product_type_id=params[:product_type_id]
     @state_id=params[:retire_note_state_id]
       begin
         if @number!="" then @sql = @sql + " and number=" + @number end
         if @customer_id!="" then @sql = @sql + " and customer_id=" + @customer_id end
         if @register_date != "" then @sql= @sql + " and date='" + @register_date +"'" end
         if @expiration_date != "" then @sql= @sql + " and expiration_date='" + @expiration_date + "'" end
         if @state_id != "" then @sql=@sql + " and retire_note_state_id=" + @state_id end
         if @product_type_id != "" then @sql=@sql + " and product_type_id=" + @product_type_id end
         #Genero la consulta
         
           if(@sql!="1=1") 
              @retire_notes=RetireNote.where(@sql)
           end
           respond_to do |format|
            format.html {render action:"index"}# index.html.erb
            format.json { head :no_content}
          end
       rescue Exception
         respond_to do |format|
          format.html {redirect_to retire_notes_path}# index.html.erb
          format.json { head :no_content}
        end 
      end
   end
        
end
