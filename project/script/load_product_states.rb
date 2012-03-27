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