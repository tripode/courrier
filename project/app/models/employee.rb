class Employee < ActiveRecord::Base
  belongs_to :function_type
  has_many :retire_notes

  has_many :routing_sheets, :dependent => :destroy
  

  FUNCTION_LIST = FunctionType.getListaFunc

end
