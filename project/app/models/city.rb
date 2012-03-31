class City < ActiveRecord::Base
  has_many :receivers
  has_many :retire_notes
  has_many :transport_guides
  belongs_to :province
  
end
