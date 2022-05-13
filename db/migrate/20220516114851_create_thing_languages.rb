class CreateThingLanguages < ActiveRecord::Migration[7.0]
  def change
    create_table :thing_languages do |t|
      t.references :thing, null: false, foreign_key: true
      t.references :language, null: false, foreign_key: true

      t.timestamps
    end
  end
end
