class Package < ActiveRecord::Base
  belongs_to :package_type
  belongs_to :retire_note
  belongs_to :customer
  belongs_to :package_state
  has_many :transport_guide_details
  
  
end
