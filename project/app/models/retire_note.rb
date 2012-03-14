class RetireNote < ActiveRecord::Base
  belongs_to :customer
  belongs_to :employee
  belongs_to :service_type
  has_many :packages, :dependent => :destroy
  has_many :retire_note_details, :dependent => :destroy
end
