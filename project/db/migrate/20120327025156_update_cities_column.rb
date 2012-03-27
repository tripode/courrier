class UpdateCitiesColumn < ActiveRecord::Migration
  def up
    remove_column :cities, :created_at
    remove_column :cities, :updated_at
  end

  def down
  end
end
