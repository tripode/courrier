class RetireNote < ActiveRecord::Base
  belongs_to :customer
  belongs_to :employee
  belongs_to :service_type
  has_many :packages
end