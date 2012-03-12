class CreateRountingSheets < ActiveRecord::Migration
  def change
    create_table :rounting_sheets do |t|
      t.integer :area_id, :null =>false
      t.integer :employee_id, :null =>false
      t.date :date
      t.integer :total_amount

    end
    add_foreign_key :rounting_sheets , :areas
    add_foreign_key :rounting_sheets , :employees
    
  end
end
