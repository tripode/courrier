class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :id
      t.string :name
      t.string :department

      t.timestamps
    end
  end
end
