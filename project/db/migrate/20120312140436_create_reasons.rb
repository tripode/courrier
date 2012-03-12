class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.string :description, :limit=>100, :null=>false
    end
  end
end
