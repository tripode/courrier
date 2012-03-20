class PackageType < ActiveRecord::Base
  has_many :products
  has_many :retire_note_details
  
end
