class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #For all action controllers a user must be on session
  before_filter :authenticate_user!
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "No tienes permisos para acceder a esta pagina."
    redirect_to root_url
  end
  
  
  
end
