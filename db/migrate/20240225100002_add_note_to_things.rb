class AddNoteToThings < ActiveRecord::Migration[7.1]
  def change
    add_column :things, :note, :string
  end
end
