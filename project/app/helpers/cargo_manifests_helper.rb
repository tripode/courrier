module CargoManifestsHelper
  #busca todos los detalles que corresponde al id de la guia de tranposrte dado
  def get_tg_details(transport_guide_id)
    tgd = TransportGuideDetail.where(transport_guide_id: transport_guide_id)
    tgd #retorna detalle de guia de transporte
  end
end
