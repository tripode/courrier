class ProductState < ActiveRecord::Base
  has_many :products
  
  def getProductStates
    ProductState.all.collect{|ps|[ps.state_name, ps.id]}
  end
end
