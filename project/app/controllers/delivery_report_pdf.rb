class DeliveryReportPdf< Prawn::Document
  def initialize(inited_at,finished_at,customer,employee,details)
    super()
    text "Informe de Entrega"
    text "Cliente:#{customer.company_name + ' ' + customer.last_name + ' ' + customer.name}"
    text "Administrador:#{employee.last_name + ' ' + employee.name}"
    text "Fecha: desde el #{inited_at} hasta el #{finished_at}"
    move_down 20
    text "A continuacion se listan todos los detalles del informe.."
    
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
    
  end
end