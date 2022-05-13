class CreateAnnotations < ActiveRecord::Migration[7.0]
  def change
    create_table :annotations do |t|
      t.references :thing, null: false, foreign_key: true
      t.string :note
      t.string :marker

      t.timestamps
    end
  end
end
