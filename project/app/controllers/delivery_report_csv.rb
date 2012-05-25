require "csv"
class DeliveryReportCsv
  def initialize(inited_at,finished_at,customer,employee,details, file_path)
   $csv_string = CSV.generate do |csv|  
        # header row 
          csv << ["Informe de Entrega"]
          csv << ["Fecha Inicio:", inited_at]
          csv << ["Fecha Fin:", finished_at]
          csv << ["Empleado:", employee.last_name + " "+ employee.name]
          csv << [" A continuacion se listan todos los detalles del informe.."]
          csv << ["Item;Codigo;Tipo Producto;Destinatario;Direccion;Recibio;Motivo no entrega"] 
          # data rows 
          
          details.collect do |detail| 
            item=(details.index(detail) + 1).to_s
            code=detail.product.bar_code
            desc=detail.product.product_type.description
            name=if detail.product.receiver_id != nil then detail.product.receiver.receiver_name else "" end
            address=if detail.product.receiver_address_id!= nil then detail.product.receiver_address.address else "" end
            who= if detail.who_received!= nil then detail.who_received  else "" end
            reason= if detail.reason_id!= nil then detail.reason.description  else "" end
            new_row=item + ";" + code + ";" + desc + ";" + name + ";" + address + ";" + who + ";" + reason
            csv << [new_row]
          end
        end
  end
  public
  def getCSV
    return $csv_string
  end
end