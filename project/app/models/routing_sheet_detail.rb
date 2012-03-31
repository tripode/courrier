class RoutingSheetDetail < ActiveRecord::Base
  belongs_to :product
  belongs_to :reason
end
