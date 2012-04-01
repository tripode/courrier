Province.transaction do
  Province.create(:name => "Itapua", :description => "Su capital es Encarnación", :country_id=> 1)
  Province.create(:name => "Central", :description => "Su capital es Aregua", :country_id=> 1)
  Province.create(:name => "Alto Parana", :description => "Su capital es Ciudad del Este", :country_id=> 1)
end
