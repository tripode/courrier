class CreateTransportGuides < ActiveRecord::Migration
  def change
    create_table :transport_guides do |t|
      t.integer :employee_id, :null=>false
      t.date :date
      t.integer :service_type_id, :null=>false
      t.integer :customer_id, :null=>false
      t.integer :foreign_company_id, :null=>false
      t.integer :area_id, :null=>false
      t.string :description, :limit=>100

    end
    add_foreign_key :transport_guides , :employees
    add_foreign_key :transport_guides , :service_types
    add_foreign_key :transport_guides , :customers
    add_foreign_key :transport_guides , :foreign_companies
    add_foreign_key :transport_guides , :areas
  end
end
