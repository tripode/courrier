class PackageToProduct < ActiveRecord::Migration
  def up
    rename_table :package_types, :product_types
    rename_table :package_states, :product_states    
  end

  def down
  end
end


