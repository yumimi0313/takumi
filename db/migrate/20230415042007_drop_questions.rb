class DropQuestions < ActiveRecord::Migration[6.1]
  def change
    drop_table :questions
  end
end
