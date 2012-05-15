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
      [details.index(detail) + 1,
      detail.product.bar_code,
      detail.product.product_type.description,
      if detail.product.receiver_id != nil then detail.product.receiver.receiver_name end,
      if detail.product.receiver_address_id!= nil then detail.product.receiver_address.address end,
      detail.who_received,
      if detail.reason_id!= nil then detail.reason.description end]
    }
    header_data=[["Item","Codigo","Tipo Producto","Destinatario","Direccion","Recibio","Motivo no entrega"]]
    t=header_data.concat(@routing_sheets_details)
    t=make_table(header_data,:cell_style => { :size => 11})
    move_down 30
    t.draw
    move_down 30
    text "Firma Mensajero:____________________"
    
  end

end