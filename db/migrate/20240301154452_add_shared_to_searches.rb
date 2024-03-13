class AddSharedToSearches < ActiveRecord::Migration[7.1]
  def change
    add_column :searches, :shared, :boolean, default: false
  end
end
