class RoutingSheetState < ActiveRecord::Base
  has_many :routing_sheets, :dependent =>:destroy
end