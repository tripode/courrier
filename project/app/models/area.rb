class Area < ActiveRecord::Base
  has_many :transport_guides
  has_many :rounting_sheets
  
end
