class TransportGuideDetail < ActiveRecord::Base
  set_primary_keys :id, :transport_guide_id
  belongs_to :package
  belongs_to :transport_guide
end
