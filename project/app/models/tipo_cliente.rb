class TipoCliente < ActiveRecord::Base
  has_many :clientes
end
