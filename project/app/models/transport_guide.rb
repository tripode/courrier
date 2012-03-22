class TransportGuide < ActiveRecord::Base
  belongs_to :customer
  belongs_to :foreign_company
  belongs_to :employee
  belongs_to :service_type
  belongs_to :transport_guide_state
  belongs_to :payment_method
  belongs_to :city
  
end
