class AddNameToCandidates < ActiveRecord::Migration[6.1]
  def change
    add_column :candidates, :name, :string
  end
end
