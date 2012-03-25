class RetireNote < ActiveRecord::Base
  belongs_to :customer
  belongs_to :employee
  belongs_to :service_type
  belongs_to :city
  belongs_to :product_types
  has_many :products, :dependent => :destroy
  has_many :retire_note_details, :dependent => :destroy
  
end
