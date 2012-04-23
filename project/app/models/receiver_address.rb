class ReceiverAddress < ActiveRecord::Base
  belongs_to :city
  belongs_to :receiver
  
  validates :id, :address, presence:true
  validates_length_of :label, :maximum => 40

  
end
