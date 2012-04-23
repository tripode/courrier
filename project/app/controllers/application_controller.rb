class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #Para tener acceso a cualquier metodo en el controller 
  # debe haber un user loggeado.
  before_filter :authenticate_user!
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "No tienes permisos para acceder a esta pagina."
    redirect_to root_url
  end

  rescue_from ActiveRecord::RecordNotFound ,  :with => :invalid_method
  rescue_from ActionController::RoutingError, :with => :route_not_found
  rescue_from ActionController::MethodNotAllowed, :with => :invalid_method

  private

  def route_not_found
    render :text => 'What the fuck are you looking for ?', :status => :not_found
  end

  def invalid_method
#    message = "Now, did your mom tell you to #{request.request_method.to_s.upcase} that ?"
#    render :text => message, :status => :method_not_allowed
    flash[:error] = "No tienes permisos para acceder a esta pagina."
    redirect_to root_url
  end
  
end
