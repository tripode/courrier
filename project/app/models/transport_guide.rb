class TransportGuide < ActiveRecord::Base
  belongs_to :areas
  belongs_to :employees
  belongs_to :service_types
  belongs_to :customers
  belongs_to :foreign_companies
end
