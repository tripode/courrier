#si van a crear otra tabla, aca datos agreguenle aca y creen un archivo
#llamado load_xxxx.rb xxxx es el nombre del modelado que crearon
#asi no borramos todos los datos y volvemos a correr load-total y solo corremos
# la que necesitamos. recuerden que este archivo solo espara bd completamente
#vacias osea bd nuevas
Area.transaction do

    Area.create(:area_name=>"ENC-CALLE-PRIN", :description=>"xxxxx")
    Area.create(:area_name=>"ENC-Z-CIRCUITO", :description=>"xxxx")
    Area.create(:area_name=>"ENC-Z-QUITERIA", :description=>"xxxx")

end
FunctionType.transaction do

    FunctionType.create(:description=>"Administrador")
    FunctionType.create(:description=>"Mensajero")
    FunctionType.create(:description=>"Secretaria")

end
City.transaction do
  City.create(:name => "Encarnacion", :department => "Itapua")
  City.create(:name => "Coronel Bogado", :department => "Itapua")
  City.create(:name => "Cambyreta", :department => "Itapua")
end
CustomerType.transaction do
  CustomerType.create(:type_name=>"Empresa")
  CustomerType.create(:type_name=>"Individual")
  CustomerType.create(:type_name=>"Currier Externa")

end
Customer.transaction do
    #Customer: Companies
    Customer.create(:name=>"", :last_name=>"",:company_name=>"Banco Continental",:ruc=>"123456-0",
                    :address=>"Direccion A",:num_identify=>100, :mobile_number=>"",:phone_number=>"071-201010",
                    :email=>"continental@gmail.com", :customer_type_id=>1)
    Customer.create(:name=>"", :last_name=>"",:company_name=>"Banco Itapua",:ruc=>"123456-1",
                    :address=>"Direccion B",:num_identify=>101, :mobile_number=>"",:phone_number=>"071-201011",
                    :email=>"itapua@gmail.com", :customer_type_id=>1)
    Customer.create(:name=>"", :last_name=>"",:company_name=>"Banco Itau",:ruc=>"123456-2",
                    :address=>"Direccion C",:num_identify=>102, :mobile_number=>"",:phone_number=>"071-201012",
                    :email=>"itau@gmail.com", :customer_type_id=>1)
    Customer.create(:name=>"", :last_name=>"",:company_name=>"Banco BBVA",:ruc=>"123456-3",
                    :address=>"Direccion D",:num_identify=>103, :mobile_number=>"",:phone_number=>"071-201013",
                    :email=>"bbva@gmail.com", :customer_type_id=>1)

   #Customer: Personal
   Customer.create(:name=>"Juan", :last_name=>"Perez",:company_name=>"",:ruc=>"3539111-0",
                    :address=>"Direccion Quiteria",:num_identify=>200, :mobile_number=>"",:phone_number=>"071-201515",
                    :email=>"juan@gmail.com", :customer_type_id=>2)
   Customer.create(:name=>"Guillermo", :last_name=>"Gonzalez",:company_name=>"",:ruc=>"3539144-1",
                    :address=>"Direccion Kennedy",:num_identify=>201, :mobile_number=>"",:phone_number=>"071-201516",
                    :email=>"guillermo@gmail.com", :customer_type_id=>2)

end
require 'date'
Employee.transaction do
    date= Time.now + 6.days
    (1..10).each do |t|
      Employee.create(
        :email=>"empleado_#{t}@server.com",
        :name=>"empleado_nombre_#{t}",
        :last_name =>"empleado_apellido_#{t}",
        :num_identity => "#{t*10000}",
        :address=>"calle cualquiera numero #{t}",
        :admission_date=>date,
        :birthday=>date,
        :salary=>1000000,
        :mobile_number=>"(09xx)00000#{t}",
        :phone_number=>"(071)00000#{t}",
        :function_type_id=>3
      )
    end
    Employee.create(
        :email=>"raulbeni@gmail.com",
        :name=>"Raul",
        :last_name =>"Benitez",
        :num_identity => "3206015",
        :address=>"Quiteria",
        :admission_date=>date,
        :birthday=>date,
        :salary=>10000000,
        :mobile_number=>"(0975)603978",
        :phone_number=>"(071)207157",
        :function_type_id=>1
      )

end

PaymentMethod.transaction do
  PaymentMethod.create(:name_payment =>"Contado", :description => "Se paga en efectivo al contado" )
  PaymentMethod.create(:name_payment =>"Credito", :description => "Financiado" )
  PaymentMethod.create(:name_payment =>"Destino", :description => "Se paga cuando se entrega en otra ciudad" )
end
ProductState.transaction do

    ProductState.create(:state_name=>"Enviado",
                        :description=>"Paquetes enviados correctamentes")
    ProductState.create(:state_name=>"No enviado",
                        :description=>"Hubo algun problema en el envio")
    ProductState.create(:state_name=>"De vuelto",
                        :description=>"Son los paquetes no enviados,
                        que se devuelven al cliente")
    ProductState.create(:state_name=>"Extraviado",
                        :description=>"Paquetes perdidos en el proceso de envio")
    ProductState.create(:state_name=>"Pendiente",
                        :description=>"Paquetes que aun no han sido enviados")

end
ProductType.transaction do

    ProductType.create(:description=>"Sobre")
    ProductType.create(:description=>"Malote")
    ProductType.create(:description=>"Caja")
    ProductType.create(:description=>"Extracto de Tarjeta")
    ProductType.create(:description=>"Extracto de Cuenta")
    ProductType.create(:description=>"Chequera")
    ProductType.create(:description=>"Tarjeta de Credito/Debito")
    ProductType.create(:description=>"Documentos Varios")

end
Reason.transaction do

    Reason.create(:description=>"Se mudó")
    Reason.create(:description=>"Fallecio")
    Reason.create(:description=>"No existe Nº de casa")
    Reason.create(:description=>"Falta Nº de casa")
    Reason.create(:description=>"No quiere recibir")
    Reason.create(:description=>"Se trasladó")
    Reason.create(:description=>"Cerrado en hora de reparto")
    Reason.create(:description=>"Falta Nº de Piso/Oficina/Dpto.")
    Reason.create(:description=>"Ya no trabaja en el lugar")
    Reason.create(:description=>"De vacaciones")
    Reason.create(:description=>"De reposo")
    Reason.create(:description=>"Casa en refacción/Casa Desocupada")
    Reason.create(:description=>"Falta Nº de local/Bloque")
    Reason.create(:description=>"Otros")

end
ServiceType.transaction do
  ServiceType.create(:description=> "Urbano")
  ServiceType.create(:description=> "Nacional")
end
TransportGuideState.transaction do
  TransportGuideState.create(:name_state=> "En Espera",
      :description=> "Cuando la Guia de tranporte aun no ha sido enviada"
  )

  TransportGuideState.create(:name_state=> "Enviado",
      :description=> "Cuando la Guia de tranporte ha sido enviada"
  )

  TransportGuideState.create(:name_state=> "Cancelado",
      :description=> "La GT fue cancelado su envio por algun error en el documento o por el cliente"
  )
  TransportGuideState.create(:name_state=> "Perdido",
      :description=> "La GT fue extraviada por algun motivo"
  )
end

#si van a crear otra tabla, aca datos agreguenle aca y creen un archivo
#llamado load_xxxx.rb xxxx es el nombre del modelado que crearon
#asi no borramos todos los datos y volvemos a correr load-total y solo corremos
# la que necesitamos. recuerden que este archivo solo espara bd completamente
#vacias osea bd nuevas


