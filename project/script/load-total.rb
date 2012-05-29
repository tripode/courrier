#si van a crear otra tabla, aca datos agreguenle aca y creen un archivo
#llamado load_xxxx.rb xxxx es el nombre del modelado que crearon
#asi no borramos todos los datos y volvemos a correr load-total y solo corremos
# la que necesitamos. recuerden que este archivo solo espara bd completamente
#vacias osea bd nuevas

FunctionType.transaction do

    FunctionType.create(:description=>"Administrador")
    FunctionType.create(:description=>"Mensajero")
    FunctionType.create(:description=>"Secretaria")

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
        :name=>"e_nombre_#{t}",
        :last_name =>"e_apellido_#{t}",
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
                        :description=>"Producto en proceso de hoja de ruta para su entrega")
    ProductState.create(:state_name=>"No enviado", 
                        :description=>"El producto no se ruteo todavia")
    ProductState.create(:state_name=>"De vuelto", 
                        :description=>"Son los productos no enviados, 
                        que se devuelven al cliente")
    ProductState.create(:state_name=>"Extraviado", 
                        :description=>"Productos perdidos en el proceso de envio")
    ProductState.create(:state_name=>"Recibido", 
                        :description=>"Producto que se entrego al destinatario")                     
    ProductState.create(:state_name=>"No Recibido", 
                        :description=>"Producto que no fue recibido por ninguna persona en la direccion dada")
    

end
ProductType.transaction do

    ProductType.create(:description=>"Sobre")
    ProductType.create(:description=>"Factura")
    ProductType.create(:description=>"Pin")
    ProductType.create(:description=>"Chequera")
    ProductType.create(:description=>"Malote")
    ProductType.create(:description=>"Caja")
    ProductType.create(:description=>"Paquete")
    ProductType.create(:description=>"Extracto de Tarjeta Credito")
    ProductType.create(:description=>"Extracto de Cuenta Corriente")
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
    Reason.create(:description=>"Producto extraviado en el reparto")
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
Country.transaction do
  Country.create(:name => "Paraguay", :description => "Su capital es Asunción")
  Country.create(:name => "Brasil", :description => "Su capital es Brasilia")
  Country.create(:name => "Argentina", :description => "Su capital es Buenos Aires")
  Country.create(:name => "Uruguay", :description => "Su capital es Montevideo")
end
Province.transaction do
   ## Provincias de Paraguay
  Province.create(:name => "Concepcion", :description => "Su capital es Concepcion", :country_id=> 1)
  Province.create(:name => "San Pedro", :description => "Su capital es San Pedro", :country_id=> 1)
  Province.create(:name => "Cordillera", :description => "Su capital es Caacupe", :country_id=> 1)
  Province.create(:name => "Caaguazu", :description => "Su capital es Coronel Oviedo", :country_id=> 1)
  Province.create(:name => "Guaira", :description => "Su capital es Villarrica", :country_id=> 1)
  Province.create(:name => "Caazapa", :description => "Su capital es Caazapa", :country_id=> 1)
  Province.create(:name => "Itapua", :description => "Su capital es Encarnacion", :country_id=> 1)
  Province.create(:name => "Misiones Py", :description => "Su capital es San Juan Bautista", :country_id=> 1)
  Province.create(:name => "Paraguari", :description => "Su capital es Paraguari", :country_id=> 1)
  Province.create(:name => "Alto Parana", :description => "Su capital es Alto Parana", :country_id=> 1)
  Province.create(:name => "Central", :description => "Su capital es Aregua", :country_id=> 1)
  Province.create(:name => "Neembucu", :description => "Su capital es Pilar", :country_id=> 1)
  Province.create(:name => "Amambay ", :description => "Su capital es Pedro Juan Caballero", :country_id=> 1)
  Province.create(:name => "Canindeyu", :description => "Su capital es Villa Hayes", :country_id=> 1)
  Province.create(:name => "Presidente Hayes", :description => "Su capital es Caazapa", :country_id=> 1)
  Province.create(:name => "Alto Paraguay", :description => "Su capital es Fuerte Olimpo", :country_id=> 1)
  Province.create(:name => "Boqueron", :description => "Su capital es Filadelfia", :country_id=> 1)
  
  ##Provincias de Argentina
  Province.create(:name => "Misiones Arg", :description => "Su capital es Posadas", :country_id=> 3)
end
City.transaction do
  City.create(:name => "Encarnacion", :province_id => 1 )
  City.create(:name => "Coronel Bogado", :province_id => 1)
  City.create(:name => "Cambyreta", :province_id => 1)
end
Area.transaction do

    Area.create(:area_name=>"ENC-CALLE-PRIN", :description=>"xxxxx", :city_id => 1)
    Area.create(:area_name=>"ENC-Z-CIRCUITO", :description=>"xxxx", :city_id => 1)
    Area.create(:area_name=>"ENC-Z-QUITERIA", :description=>"xxxx", :city_id => 1)

end
Receiver.transaction do
  Receiver.create(:receiver_name => "Villalba Teresa",:document=> "3539120")
  Receiver.create(:receiver_name => "Ocampo Rober",  :document=> "4500632")
  Receiver.create(:receiver_name => "Monges Karla",  :document=> "3539456")
  Receiver.create(:receiver_name => "Espinoza Jose", :document=> "3120000")
  Receiver.create(:receiver_name => "Garcete Sofia", :document=> "4258966")
end
ReceiverAddress.transaction do
  ReceiverAddress.create(:label => "Casa", :address => "direccion casa", :city_id => 1, :receiver_id => 1)
  ReceiverAddress.create(:label => "Oficina", :address => "direccion oficina", :city_id => 1, :receiver_id => 1)
  ReceiverAddress.create(:label => "Casa", :address => "direccion casa", :city_id => 2, :receiver_id => 2)
  ReceiverAddress.create(:label => "Oficina", :address => "direccion oficina", :city_id => 1, :receiver_id => 2)
  ReceiverAddress.create(:label => "Facultad", :address=> "direccion facultad", :city_id => 3, :receiver_id => 3)
  ReceiverAddress.create(:label => "Casa", :address => "direccion casa", :city_id => 1, :receiver_id => 3)
  ReceiverAddress.create(:label => "Oficina", :address => "direccion oficina", :city_id => 1, :receiver_id => 3)
  ReceiverAddress.create(:label => "Casa 1", :address => "direccion casa 1", :city_id => 1, :receiver_id => 4)
  ReceiverAddress.create(:label  => "Casa 2", :address => "direccion casa 2", :city_id => 1, :receiver_id => 4)
  ReceiverAddress.create(:label => "Casa 3", :address => "direccion casa 3", :city_id => 1, :receiver_id => 4)
end
RetireNoteState.transaction do
  RetireNoteState.create(:state_name => "Procesado")
  RetireNoteState.create(:state_name => "En Proceso")
  RetireNoteState.create(:state_name => "Perdido")
  RetireNoteState.create(:state_name => "Cancelado")
end
Role.transaction do

    Role.create(:name=> "Administrador")
    Role.create(:name=> "Repartidor")
    Role.create(:name=> "Secretaria")

end
User.transaction do
  
    User.create(:username     => 'admin',
                :email        => 'admin@admin.com',
                :password     => 'pass',
                :employee_id  => Employee.first.id,
                :role_ids     => Role.where(:name => 'Administrador').first.id
               )
end
RoutingSheetState.transaction do
  RoutingSheetState.create(:state_name => "En Proceso", :description => "Actualmente entregando los productos de esta hoja de ruta")
  RoutingSheetState.create(:state_name => "Procesado", :description => "Los productos de la hoja de ruta fueron entregados")
  RoutingSheetState.create(:state_name => "Cancelado", :description => "La hoja de ruta ha sido cancelada")
end
#si van a crear otra tabla, aca datos agreguenle aca y creen un archivo
#llamado load_xxxx.rb xxxx es el nombre del modelado que crearon
#asi no borramos todos los datos y volvemos a correr load-total y solo corremos
# la que necesitamos. recuerden que este archivo solo espara bd completamente
#vacias osea bd nuevas


