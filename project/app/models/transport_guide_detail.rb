class TransportGuideDetail < ActiveRecord::Base
#  self.primary_keys :id, :transport_guide_id
  belongs_to :transport_guide
  belongs_to :product_type
end
