class RoutingSheetPdf< Prawn::Document

  def initialize(routing_sheet, details)
    super()
    @routing_sheet = routing_sheet
    text "Hoja de Ruta" 
    text "Nro:#{@routing_sheet.number}"
    text "Fecha:#{@routing_sheet.date}"
    text "Repartidor:#{@routing_sheet.employee.last_name + ' '  + @routing_sheet.employee.name}"
    text "Zona:#{@routing_sheet.area.area_name}"
    text "OBS:#{@routing_sheet.commentary}"
    @routing_sheets_details=details.collect{|detail| 
      [detail.product.bar_code,
      detail.product.product_type.description,
      detail.product.receiver.receiver_name,
      detail.product.receiver_address.address,
      detail.who_received,
      if detail.reason_id!= nil then detail.reason.description end]
    }
    table(@routing_sheets_details)
  end

end