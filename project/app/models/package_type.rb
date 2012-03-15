class PackageType < ActiveRecord::Base
  has_many :packages
  has_many :retire_note_details
  has_many :routing_sheets
end
