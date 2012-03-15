class RoutingSheet < ActiveRecord::Base
  belongs_to :routing_sheet_state
  belongs_to :area
  belongs_to :employee
  belongs_to :package_type
end
