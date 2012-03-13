class RetireNoteDetail < ActiveRecord::Base
  belongs_to :retire_note
  belongs_to :package_type
end
