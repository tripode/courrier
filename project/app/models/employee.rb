class Employee < ActiveRecord::Base
  belongs_to :function_type
  has_many :retire_notes
  has_many :transport_guides

  has_many :routing_sheets, :dependent => :destroy
  
  
  
  def buscarFunctionType
    FunctionType.all.collect{|tp|[tp.description, tp.id]}
  end
  

  def format_birthday
    birthday.strftime("%d-%m-%Y") if birthday
    
  end
  def format_admission_date
    admission_date=Date.today
    admission_date.strftime("%d-%m-%Y") if admission_date
    
    
  end
  
  
    
end
