class DeleteColumnPackages < ActiveRecord::Migration
  def up
    remove_foreign_key :packages, :employees
    remove_column :packages, :employee_id
    remove_column :packages, :admission_date
  end

  def down
  end
end
