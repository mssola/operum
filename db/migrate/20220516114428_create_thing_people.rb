class CreateThingPeople < ActiveRecord::Migration[7.0]
  def change
    create_table :thing_people do |t|
      t.references :thing, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
