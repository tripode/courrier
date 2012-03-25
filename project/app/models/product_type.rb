class PackageType < ActiveRecord::Base
  has_many :products
  has_many :transport_guide_details, :foreign_key => [:id, :transport_guide_id]
  has_many :retire_notes
  
end
