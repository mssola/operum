class ChangeAccessAndBoughtAtToDate < ActiveRecord::Migration[7.1]
  def change
    change_column :things, :access, :date
    change_column :things, :bought_at, :date
  end
end
