class Customer < ActiveRecord::Base

  belongs_to :customer_type
  has_many :retire_notes

  has_many :transport_guides

end
