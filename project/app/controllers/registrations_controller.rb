class RegistrationsController < Devise::RegistrationsController
  
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
    authorize! :create, User
  end

  layout "application" 
    #
    # This override the new method, it's for sign_up path, 
    # if exist a user on session it permit access to sign_up;
    # redirect to root_path otherwise.
    #
    def new
      if current_user
        super
      else
        redirect_to root_path
      end
    end

 
  def create
    super
  end

  def update
    super
  end
  
  #
  # This action controller delete a user.
  #
  def delete_user
    @deleted_user = User.find(params[:id])
    @deleted_user.destroy
  end

  
end 