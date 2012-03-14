class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  def current_employee
    Employee.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    employee = Employee.new
    employee
  end
end
