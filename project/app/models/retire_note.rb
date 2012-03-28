class RetireNote < ActiveRecord::Base
  belongs_to :customer
  belongs_to :employee
  belongs_to :service_type
  belongs_to :city
  belongs_to :product_type
  
  def getTipoServicios
    ServiceType.all.collect{|tp|[tp.description, tp.id]}
  end
   def getClientes
    Customer.all.collect{|c|
      [if c.company_name.nil? then (c.last_name + " "+ c.name) else c.company_name end, c.id]}
  end
  def getTipoProductos
    ProductType.all.collect{|tp|[tp.description, tp.id]}
  end
  def getCiudades()
    City.all.collect{|c|[c.name, c.id]}
  end
end
