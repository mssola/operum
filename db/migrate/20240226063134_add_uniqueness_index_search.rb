class AddUniquenessIndexSearch < ActiveRecord::Migration[7.1]
  def change
    add_index :searches, :name, unique: true
    add_index :searches, :body, unique: true

    add_index :things, :target, unique: true
  end
end
