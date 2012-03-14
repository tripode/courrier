class TransportGuide < ActiveRecord::Base
  belongs_to :area
  belongs_to :employee
  belongs_to :service_type
  belongs_to :customer
  belongs_to :foreign_company
  has_many :transport_guide_details
end
