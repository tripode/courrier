class Employee < ActiveRecord::Base
  belongs_to :function_types
  has_many :transport_guides
end
