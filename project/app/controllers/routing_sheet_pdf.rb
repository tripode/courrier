## Esta clase genera en formato pdf la hoja de ruta para que el repartidor imprima
## y salga a repartir los productos
class RoutingSheetPdf< Prawn::Document

  def initialize(routing_sheet, details, root_url)
    super()
    
    @routing_sheet = routing_sheet
     number_pages "Pag:<page>", 
                                         {:start_count_at => 1,
                                          :page_filter => lambda{ |pg| pg != 0 },
                                          :at => [bounds.right - 50, 678],
                                          :align => :right,
                                          :size => 10}
    text "Hoja de Ruta", :align => :left 
    text "DS Representaciones"
    draw_text "#{routing_sheet.date.strftime("%d-%m-%Y")}", :at => [480, 708]
    move_down 15
    text "Numero hoja ruta: #{@routing_sheet.number}     Repartidor: #{@routing_sheet.employee.last_name + ' '  + @routing_sheet.employee.name}      Zona: #{@routing_sheet.area.area_name}"
    
    @routing_sheets_details=details.collect{|detail| 
      [
      detail.product.bar_code,
      if !detail.product.receiver_id.nil? then detail.product.receiver.receiver_name end  + "\n  " +
      if !detail.product.receiver_address_id.nil? then detail.product.receiver_address.address end,
      "________________",
      "_____________________________"]
    }
    move_down 15
    header_data=[["CODIGO","DATOS DE USUARIO","FIRMA","ACLARACION"]]
    t_header = make_table(header_data,:cell_style => { :font => "Helvetica",:font_style => :bold,:size => 10,:border_width => 0},:column_widths => { 0 => 80, 1 => 150, 2 => 100, 3 => 180})
    t_header.draw
    t=make_table(@routing_sheets_details,:cell_style => { :font => "Helvetica", :size => 10, :border_width => 0 },:column_widths => { 0 => 80, 1 => 150,2 => 100, 3 => 180})
    t.draw
    move_down 10
    text "Total: #{details.length}"
    move_down 30
    text "Firma Mensajero:____________________"
   
   
    
   
  end

end