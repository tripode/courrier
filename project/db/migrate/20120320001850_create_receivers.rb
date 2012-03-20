class CreateReceivers < ActiveRecord::Migration
  def change
    create_table :receivers do |t|
      t.integer :id
      t.string :receiver_name
      t.string :address
      t.integer :city_id
      t.string :document

      t.timestamps
    end
    add_foreign_key :receivers , :cities
  end
  
end
