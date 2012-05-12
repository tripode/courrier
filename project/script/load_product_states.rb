ProductState.transaction do

    ProductState.create(:state_name=>"Enviado", 
                        :description=>"Producto en proceso de hoja de ruta para su entrega")
    ProductState.create(:state_name=>"No enviado", 
                        :description=>"El producto no se ruteo")
    ProductState.create(:state_name=>"De vuelto", 
                        :description=>"Son los productos no enviados, 
                        que se devuelven al cliente")
    ProductState.create(:state_name=>"Extraviado", 
                        :description=>"Productos perdidos en el proceso de envio")
    ProductState.create(:state_name=>"Pendiente", 
                        :description=>"Producto que aun no han sido enviados")
     ProductState.create(:state_name=>"Entregado", 
                        :description=>"Producto que se entrego al destinatario")

end