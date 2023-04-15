class AddNullFalseToCraftmen < ActiveRecord::Migration[6.1]
  def change
    change_column_null :craftmen, :category, false
    change_column_null :craftmen, :company_name, false
    change_column_null :craftmen, :prefecture, false
    change_column_null :craftmen, :manicipal, false
  end
end
