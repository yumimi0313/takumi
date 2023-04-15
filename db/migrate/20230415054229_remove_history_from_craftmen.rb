class RemoveHistoryFromCraftmen < ActiveRecord::Migration[6.1]
  def change
    remove_column :craftmen, :history, :text
  end
end
