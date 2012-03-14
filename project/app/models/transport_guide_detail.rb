class TransportGuideDetail < ActiveRecord::Base
  # set_primary_keys :id, :transport_guide_id
  belongs_to :transport_guides
  belongs_to :packages
end
