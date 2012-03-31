class TransportGuideState < ActiveRecord::Base
  has_many :transport_guides
  #metodo par a listar las Estado de guia
  #de tranporte en select
  def self.get_list_guide_state
    all.collect{|tp| [tp.name_state, tp.id]}
  end
end
