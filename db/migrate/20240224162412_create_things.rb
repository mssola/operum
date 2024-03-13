class CreateThings < ActiveRecord::Migration[7.1]
  def change
    create_table :things do |t|
      t.string :target
      t.string :title, null: false, index: { unique: true }
      t.string :publisher
      t.string :address
      t.integer :year
      t.string :url
      t.datetime :access
      t.string :location
      t.string :insideof
      t.string :pages
      t.references :user, null: false, foreign_key: true
      t.integer :rate
      t.integer :status
      t.integer :kind
      t.datetime :bought_at

      t.timestamps
    end
  end
end
