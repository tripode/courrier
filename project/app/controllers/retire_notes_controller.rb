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
    flash[:notice]=""
    @retire_note = RetireNote.find(params[:id])
   
      
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @retire_note}
    
    end
  end

  # GET /retire_notes/new
  # GET /retire_notes/new.json
  def new
    flash[:notice]=""
    @retire_note = RetireNote.new
    @retire_note.employee_id=current_user.employee.id
    @customer = Customer.new
    @customers = Customer.find(:all)
    @employees = Employee.find(:all)
    #En la lista muestro todas las notas de retiro no procesadas cuya fecha sea hasta 31 dias antes de la fecha actual
    @retire_notes= RetireNote.find(:all, :conditions=> "retire_note_state_id= 2 and date between current_date-31 and current_date")
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
      format.js
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
            #Initialize al variables
            @retire_note = RetireNote.new
            @retire_note.employee_id=current_user.employee.id
            @customer = Customer.new
            @customers = Customer.find(:all)
            @employees = Employee.find(:all)
            #En la lista muestro todas las notas de retiro no procesadas cuya fecha sea hasta 31 dias antes de la fecha actual
            @retire_notes= RetireNote.find(:all, :conditions=> "retire_note_state_id= 2 and date between current_date-31 and current_date")
            flash[:notice]="La nota de retiro se guardo correctamente."
          else
             #Initialize al variables
            @retire_note = RetireNote.new
            @retire_note.employee_id=current_user.employee.id
            @customer = Customer.new
            @customers = Customer.find(:all)
            @employees = Employee.find(:all)
            #En la lista muestro todas las notas de retiro no procesadas cuya fecha sea hasta 31 dias antes de la fecha actual
            @retire_notes= RetireNote.find(:all, :conditions=> "retire_note_state_id= 2 and date between current_date-31 and current_date")
            flash[:notice]="No se pudo guardar la nota de retiro."
          end
      rescue
        flash[:notice]="No se pudo guardar la nota de retiro."
      ensure
         format.js
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
            #Initialize al variables
            @retire_note = RetireNote.new
            @retire_note.employee_id=current_user.employee.id
            @customer = Customer.new
            @customers = Customer.find(:all)
            @employees = Employee.find(:all)
            #En la lista muestro todas las notas de retiro no procesadas cuya fecha sea hasta 30 dias antes de la fecha actual
            @retire_notes= RetireNote.find(:all, :conditions=> "retire_note_state_id= 2 and date between current_date-31 and current_date")
            
            flash[:notice]='La nota de retiro ha sido actualizada'
           
          else
             #Initialize al variables
            @retire_note = RetireNote.new
            @retire_note.employee_id=current_user.employee.id
            @customer = Customer.new
            @customers = Customer.find(:all)
            @employees = Employee.find(:all)
            #En la lista muestro todas las notas de retiro no procesadas cuya fecha sea hasta 30 dias antes de la fecha actual
            @retire_notes= RetireNote.find(:all, :conditions=> "retire_note_state_id= 2 and date between current_date-31 and current_date")
            flash[:notice]='No se pudo actualizar el nota de retiro'
       
          end
      rescue
        flash[:notice]='Error:No se pudo actualizar el nota de retiro'
      ensure
         format.js
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
        flash[:notice]="La nota de retiro ha sido eliminada.."
      rescue
        flash[:notice]="Esta nota de retiro no puede ser eliminada.."
      ensure
       
        #Initialize al variables
            @retire_note = RetireNote.new
            @retire_note.employee_id=current_user.employee.id
            @customer = Customer.new
            @customers = Customer.find(:all)
            @employees = Employee.find(:all)
            #En la lista muestro todas las notas de retiro no procesadas cuya fecha sea hasta 31 dias antes de la fecha actual
            @retire_notes= RetireNote.find(:all, :conditions=> "retire_note_state_id= 2 and date between current_date-31 and current_date")
            
       
       format.js 
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
         valid_number=/^\d+$/.match(@number)
         if valid_number!= nil then @sql = @sql + " and number=" + @number end
         valid_customer_id=/^\d+$/.match(@customer_id)
         if valid_customer_id!=nil then @sql = @sql + " and customer_id=" + @customer_id end
         valid_register_date=/[0-9]{2}-[0-9]{2}-[0-9]{4}/.match(@register_date)
         if valid_register_date!=nil then @sql= @sql + " and date='" + @register_date +"'" end
         valid_expiration_date=/[0-9]{2}-[0-9]{2}-[0-9]{4}/.match(@expiration_date)
         if valid_expiration_date != nil then @sql= @sql + " and expiration_date='" + @expiration_date + "'" end
         valid_state_id=/^\d+$/.match(@state_id)
         if valid_state_id!=nil then @sql=@sql + " and retire_note_state_id=" + @state_id end
         valid_product_type_id=/^\d+$/.match(@product_type_id)
         if valid_product_type_id!=nil then @sql=@sql + " and product_type_id=" + @product_type_id end
         #Genero la consulta
         
           if(@sql!="1=1") 
              @retire_notes=RetireNote.where(@sql)
           end
           respond_to do |format|
            #format.html {render action:"index"}# index.html.erb
            #format.json { head :no_content}
            format.js
          end
       rescue Exception
         respond_to do |format|
          format.html {redirect_to retire_notes_path}# index.html.erb
          format.json { head :no_content}
        end 
      end
   end
   
   #Este metodo permite setear obtener el precio para la nota de retiro
   #teniendo en cuenta el cliente, el tipo de producto y la ciudad     
   def getPrice
     @customer_id = params[:customer_id]
     @product_type_id = params[:product_type_id]
     @city_id = params[:city_id]
     @current_date = params[:current_date]
     @from_date = @current_date.to_date - 1.month    
     @retire_note = RetireNote.where("customer_id=? and product_type_id=? and city_id=? and date between ? and ?", @customer_id,@product_type_id, @city_id,@from_date.to_s,@current_date.to_date).last
     @price = 0
     if @retire_note != nil then
       @price = @retire_note.unit_price
     end
     @the_price = {"value" => @price}
     respond_to do |format|
      format.html # 
      format.json { render json: @the_price }
    end
   end
end
