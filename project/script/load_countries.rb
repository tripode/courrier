Country.transaction do
  Country.create(:name => "Paraguay", :description => "Su capital es Asunción")
  Country.create(:name => "Brasil", :description => "Su capital es Brasilia")
  Country.create(:name => "Argentina", :description => "Su capital es Buenos Aires")
end