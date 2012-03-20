class RetireNoteDetail < ActiveRecord::Base
  belongs_to :retire_note
  belongs_to :product_type
  belongs_to :city_id
end
