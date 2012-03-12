class Employee < ActiveRecord::Base
  belongs_to :function_types
  has_many :transport_guides
  has_many :rounting_sheets
end
