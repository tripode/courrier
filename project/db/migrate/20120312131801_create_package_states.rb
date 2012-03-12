class CreatePackageStates < ActiveRecord::Migration
  def change
    create_table :package_states do |t|
      t.string :state_name, :limit=>20, :null=>false
      t.string :description, :limit=>100

    end
  end
end
