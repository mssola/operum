class AddDescriptionToSearch < ActiveRecord::Migration[8.0]
  def change
    add_column :searches, :description, :text
  end
end
