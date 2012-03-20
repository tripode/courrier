class DeleteCustomerFromProduct < ActiveRecord::Migration
  def up
    remove_column :products, :customer_id
  end

  def down
  end
end
