class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication

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
end 