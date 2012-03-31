class Receiver < ActiveRecord::Base
  belongs_to :city
  has_many :products
end
