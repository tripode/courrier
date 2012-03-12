class Employee < ActiveRecord::Base


  has_many :retire_notes
  belongs_to :function_type
  has_many :transport_guides
  has_many :rounting_sheets

end
