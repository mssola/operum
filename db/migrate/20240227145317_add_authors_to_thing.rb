class AddAuthorsToThing < ActiveRecord::Migration[7.1]
  def change
    add_column :things, :authors, :string, null: false
    add_column :things, :editors, :boolean, default: false
  end
end
