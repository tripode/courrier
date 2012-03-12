class Customer < ActiveRecord::Base
  belongs_to :customer_types
  has_many :transport_guides
end
