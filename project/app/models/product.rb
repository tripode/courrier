class Product < ActiveRecord::Base
  belongs_to :product_type
  belongs_to :retire_note
  belongs_to :customer
  belongs_to :product_state
  
  
end