class Area < ActiveRecord::Base
  has_many :transport_guides, :dependent => :destroy
  has_many :routing_sheets, :dependent => :destroy
  
end
