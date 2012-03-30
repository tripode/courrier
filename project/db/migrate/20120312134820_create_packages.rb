class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.integer :num_code, :null=>false
      t.string :description, :limit=>100
      t.integer :package_type_id, :null=>false
      t.integer :retire_note_id, :null=>false
      t.integer :employee_id, :null=>false
      t.string :remitter, :limit=>100
      t.string :address, :limit=>100
      t.integer :customer_id, :null=>false
      t.string :fragile, :select=>"Si, No", :limit=>5, :null=>false    
      t.integer :package_state_id, :null=>false
      t.date :admission_date

      t.timestamps
    end
    add_foreign_key :packages , :package_types
    add_foreign_key :packages , :retire_notes
    add_foreign_key :packages , :employees
    add_foreign_key :packages , :customers
    add_foreign_key :packages , :package_states
  end
end
