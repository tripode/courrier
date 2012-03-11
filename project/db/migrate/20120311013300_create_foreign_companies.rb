class CreateForeignCompanies < ActiveRecord::Migration
  def change
    create_table :foreign_companies do |t|
      t.integer :id
      t.string :company_name, :limits => 30
      t.string :mobile_number, :limits => 20
      t.string :email, :limits => 60
      t.string :ruc, :limits => 15
      t.string :address, :limits => 100
      t.string :phone_number, :limits => 20

    end
  end
end
