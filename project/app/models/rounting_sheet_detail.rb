class RountingSheetDetail < ActiveRecord::Base
  # set_primary_keys :id, :rounting_sheet_id
  belongs_to :reasons
  belongs_to :packages
  belongs_to :rounting_sheets
end
