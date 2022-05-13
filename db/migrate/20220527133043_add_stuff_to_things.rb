class AddStuffToThings < ActiveRecord::Migration[7.0]
  def change
    add_column :things, :rate, :integer, default: 0
    add_column :things, :status, :integer, default: 0
    add_column :things, :kind, :integer, default: 0
    add_column :things, :bought_at, :datetime
  end
end
