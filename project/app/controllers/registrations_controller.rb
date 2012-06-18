class RegistrationsController < Devise::RegistrationsController
 #
  # Antes de hacer cualquier cosa con este controler,
  # se verifica si hay permiso para el usuario logueado
  #
  before_filter :check_permissions, :only => [:new, :create, :delete_user]
  skip_before_filter :require_no_authentication
  #
  # Llama a este metodo y verifica los permisos que tiene para City
  #
  def check_permissions
    authorize! :create, :new, :delete_user, User
  end
  
  layout "application" 
    #
    # This override the new method, it's for sign_up path, 
    # if exist a user on session it permit access to sign_up;
    # redirect to root_path otherwise.
    #
    def new
      if(params[:messages])
        @messages = params[:messages]
      end
      if current_user
        @employees = Employee.all
        super
      else
        redirect_to root_path
      end
    end

 
 def create
    build_resource
    resource.employee_id = params[:employee_id]
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        #sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  #def create
  # super
  #end

  def update
    super
  end
  
  #
  # This action controller delete a user.
  #
  def delete_user
    Rails.logger = Logger.new(STDOUT)
    puts params.to_yaml
    logger.info params.to_yaml
    if(current_user.id.to_s != params[:id].to_s and params[:id].to_s!=1.to_s)
      @deleted_user = User.find(params[:id])
      begin
        @deleted_user.destroy
        @messages = {:success => "El usuario fue eliminado exitosamente"}
      rescue Exception => e
        @messages = {:error => "Hubo un error al intentar eliminar el usuario"}
      end
    else
      @messages = {:alert => "No se puede eliminar este usuario"}
    end
    redirect_to new_user_registration_path(:messages => @messages)
  end

  protected
  
  
  def after_sign_up_path_for(resource)
    new_user_registration_path
  end 
  
  def edit
    super
  end
  
end 