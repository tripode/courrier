class Receiver < ActiveRecord::Base
  belongs_to :city
  has_many :products
  
  validates :receiver_name, :address, :id, :presence => true
  validates_length_of :receiver_name, :maximum => 60
  validates_length_of :document, :maximum => 25
  
end
