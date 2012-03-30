class CreateRetireNoteDetails < ActiveRecord::Migration
def change
    create_table :retire_note_details do |t|
      t.integer :id
      t.integer :retire_note_id
      t.integer :package_type_id
      t.integer :amount
    end
    add_foreign_key :retire_note_details, :retire_notes
    add_foreign_key :retire_note_details, :package_types
  end
end