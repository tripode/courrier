class UpdateRoutingSheet < ActiveRecord::Migration
  def up
    remove_column :routing_sheets, :package_type_id
    add_column :routing_sheets, :commentary, :string
    add_column :routing_sheets, :state, :string
  end

  def down
  end
end
