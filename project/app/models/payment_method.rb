class PaymentMethod < ActiveRecord::Base
  has_many :transport_guides
end
