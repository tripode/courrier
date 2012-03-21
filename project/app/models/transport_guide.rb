class TransportGuide < ActiveRecord::Base
  belongs_to :costumer
  belongs_to :foreign_company
  belongs_to :employee
  belongs_to :service_type
  belongs_to :payment_method
end
