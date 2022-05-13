class AddUserIdToThing < ActiveRecord::Migration[7.0]
  def change
    add_reference :things, :user, null: false, foreign_key: true
  end
end
