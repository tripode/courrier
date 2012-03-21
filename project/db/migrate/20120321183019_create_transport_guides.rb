class CreateTransportGuides < ActiveRecord::Migration
  def change
    create_table :transport_guides do |t|
      t.integer :customer_id, :null =>false
      t.integer :foreign_company_id, :null=> false
      t.integer :employee_id, :null=> false
      t.integer :service_type_id, :null=>false
      #debe estar en un select
      t.string :state, :nul=> false, :limit=>20
      t.integer :payment_method_id, :null=>false

      t.timestamps
    end
    add_foreign_key :transport_guides, :customers
    add_foreign_key :transport_guides, :foreign_companies
    add_foreign_key :transport_guides, :employees
    add_foreign_key :transport_guides, :service_types
    add_foreign_key :transport_guides, :payment_methods
  end
end
