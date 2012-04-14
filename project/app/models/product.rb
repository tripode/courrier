class Product < ActiveRecord::Base
  belongs_to :product_type
  belongs_to :retire_note
  belongs_to :product_state
  belongs_to :receiver
  has_many :routing_sheet_details
  
   validates :retire_note_id, :receiver_id, :remitter, :product_type_id,
    :fragile, :product_state_id,:bar_code,:created_at, :presence =>true
    
  def format_admission_date
    admission_date=Date.today
    admission_date.strftime("%d-%m-%Y") if admission_date
    
    
  end
end
