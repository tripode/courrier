class City < ActiveRecord::Base
  has_many :receivers
  has_many :retire_note_details
end
