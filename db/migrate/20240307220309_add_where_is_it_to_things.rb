class AddWhereIsItToThings < ActiveRecord::Migration[7.1]
  def change
    add_column :things, :where_is_it, :string
  end
end
