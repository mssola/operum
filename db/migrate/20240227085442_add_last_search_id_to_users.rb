class AddLastSearchIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_search_id, :integer
  end
end
