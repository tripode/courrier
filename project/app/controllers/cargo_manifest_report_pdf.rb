class CargoManifestReportPdf < Prawn::Document
  def initialize(create_date,employee,cargo_manifest,url_new, root_url, file_path)
    super()
    text "Manifiesto de carga"
    text "Empleado:#{employee.last_name + ' ' + employee.name}"
    text "Trayecto: #{cargo_manifest.origin_city_id} - #{cargo_manifest.destiny_city_id}"
    text "Fecha de creación: #{create_date}"
    move_down 20
    text "A continuacion se listan todos los detalles.."
    cargo_manifest_detail = CargoManifestDetail.where(cargo_manifest_id: cargo_manifest.id);
#    tg_detail=Set.new
#    cargo_manifest_detail.each do |t|
#      tg_detail.add(TransportGuideDetail.where(transport_guide_id: t.id))
#    end

    @cargo_manifest_details=cargo_manifest_detail.collect{|d|
      detail = TransportGuide.find(d.transport_guide_id)
#      arreglo = Hash.new
      [ cargo_manifest_detail.index(d) + 1,
        detail.remitter_person,
        detail.destination_person,
        detail.customer.company_name,
      ]
    }
    header_data=[["N#","Remitente","Destinatario","Cliente"]]
    t=header_data.concat(@cargo_manifest_details)
    t=make_table(header_data,:cell_style => { :font => "Times-Roman", :font_style => :italic, :size => 10}) #:underline_header
    move_down 30
    t.draw
    move_down 30
    text "<u><link href='#{url_new}'>Nuevo reporte</link></u>  <u><link href='#{root_url}main_page/index'>Cancelar</link></u> ", :inline_format => true
  end
end
