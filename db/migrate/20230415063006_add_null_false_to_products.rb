class AddNullFalseToProducts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :products, :name, false
  end
end
