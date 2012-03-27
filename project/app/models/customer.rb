class Customer < ActiveRecord::Base

  belongs_to :customer_type
  has_many :retire_notes
  has_many :transport_guides

  def getClientes
    Customers.all.collect{|c|
      [if c.company_name.nil? then (c.last_name + c.name) else c.company_name end, c.id]}
  end

end
