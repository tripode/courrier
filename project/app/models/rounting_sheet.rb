class RountingSheet < ActiveRecord::Base
  belongs_to :areas
  belongs_to :employees
  has_many :rounting_sheet_details
end
