class CreateTransportGuideDetails < ActiveRecord::Migration
  def change
    create_table :transport_guide_details do |t|
      t.integer :transport_guide_id, :null=>false
      t.integer :package_id, :null=>false
      t.integer :amount, :null=>false
    end
    add_foreign_key :transport_guide_details , :packages
    add_foreign_key :transport_guide_details , :transport_guides
  end
end
