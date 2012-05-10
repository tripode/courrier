class RoutingSheet < ActiveRecord::Base
  belongs_to :routing_sheet_state
  belongs_to :area
  belongs_to :employee
  
  def format_admission_date
    admission_date=Date.today
    admission_date.strftime("%d-%m-%Y") if admission_date
  end
 
end
