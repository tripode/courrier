class RoutingSheet < ActiveRecord::Base
  belongs_to :routing_sheet_state
  belongs_to :area
  belongs_to :employee
end
