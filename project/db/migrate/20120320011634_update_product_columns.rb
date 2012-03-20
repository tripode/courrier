class UpdateProductColumns < ActiveRecord::Migration
  def up
    rename_column :packages, :package_type_id, :product_type_id
    rename_column :packages, :package_state_id, :product_state_id
    
    rename_table :packages, :products
  end

  def down
  end
end
