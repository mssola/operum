class RemoveUniquenessIndexOnTitleThings < ActiveRecord::Migration[7.1]
  def change
    remove_index :things, :title
  end
end
