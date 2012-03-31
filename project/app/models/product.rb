class Product < ActiveRecord::Base
  belongs_to :product_type
  belongs_to :retire_note
  belongs_to :product_state
  
  has_many :routing_sheet_details
  
end
