class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #For all action controllers a user must be on session
  before_filter :authenticate_user!
end
