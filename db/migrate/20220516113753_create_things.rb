class CreateThings < ActiveRecord::Migration[7.0]
  def change
    create_table :things do |t|
      t.string :target, null: false, index: { unique: true }
      t.string :title, null: false, index: { unique: true }
      t.string :publisher
      t.string :address
      t.integer :year
      t.string :url
      t.datetime :access
      t.string :location
      t.string :insideof
      t.string :pages
      t.string :note

      t.timestamps
    end
  end
end
