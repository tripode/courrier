class ServiceType < ActiveRecord::Base
  has_many :retire_notes
  has_many :transport_guides

end
