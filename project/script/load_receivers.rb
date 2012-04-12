Receiver.transaction do
  Receiver.create(:receiver_name => "Villalba Teresa", :address => "Direccion 1", :city_id=> "1", :document=> "3539120")
  Receiver.create(:receiver_name => "Ocampo Rober", :address => "Direccion 2", :city_id=> "2", :document=> "4500632")
  Receiver.create(:receiver_name => "Monges Karla", :address => "Direccion 3", :city_id=> "3", :document=> "3539456")
  Receiver.create(:receiver_name => "Espinoza Jose", :address => "Direccion xxx", :city_id=> "1", :document=> "3120000")
  Receiver.create(:receiver_name => "Garcete Sofia", :address => "Direccion 1", :city_id=> "1", :document=> "4258966")
end