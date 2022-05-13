class CreateGroupThings < ActiveRecord::Migration[7.0]
  def change
    create_table :group_things do |t|
      t.references :group, null: false, foreign_key: true
      t.references :thing, null: false, foreign_key: true

      t.timestamps
    end

    add_index :group_things, [:group_id, :thing_id], unique: true
  end
end
