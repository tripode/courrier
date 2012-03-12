class Customer < ActiveRecord::Base
  belongs_to :customer_type
  has_many :retire_notes
end
