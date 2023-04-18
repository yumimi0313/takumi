class AddNullFalseToCandidates < ActiveRecord::Migration[6.1]
  def change
    change_column_null :candidates, :name, false
    change_column_null :candidates, :interested_category, false
    change_column_null :candidates, :prefecture, false
  end
end
