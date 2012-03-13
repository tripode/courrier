class CreateRountingSheetDetails < ActiveRecord::Migration
  def change
    create_table :rounting_sheet_details do |t|
      t.integer :routing_sheet_id, :null=>false
      t.string :description, :limit=>100
      t.string :who_received, :limit=>100
      t.string :received, :select=>'si,no', :limit=>5
      t.integer :package_id, :null=>false
      t.integer :reason_id, :null=>false

    end
    add_foreign_key :rounting_sheet_details, :routing_sheets
    add_foreign_key :rounting_sheet_details, :packages
    add_foreign_key :rounting_sheet_details, :reasons
  end
end
