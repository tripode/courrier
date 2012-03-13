class Package < ActiveRecord::Base
  belongs_to :package_types
  belongs_to :retire_notes
  belongs_to :employees
  belongs_to :customers
  belongs_to :package_states
  
  
end
