class Receiver < ActiveRecord::Base
  belongs_to :city
  has_many :products
  has_many :receiver_addresses
  
end
