class Employee < ActiveRecord::Base
  belongs_to :function_type
  has_many :retire_notes
  has_many :transport_guides

  has_many :routing_sheets, :dependent => :destroy
  
  

  def format_birthday
    birthday.strftime("%d/%m/%Y") if birthday
    
  end
end
