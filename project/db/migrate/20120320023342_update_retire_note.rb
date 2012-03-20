class UpdateRetireNote < ActiveRecord::Migration
  def up
    add_column :retire_notes, :state, :string
    add_column :retire_notes, :expiration_date, :datetime
  end

  def down
  end
end
