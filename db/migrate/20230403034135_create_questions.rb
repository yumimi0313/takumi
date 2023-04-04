class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :interview, null: false, foreign_key: true
      t.text :content
      t.text :answer

      t.timestamps
    end
  end
end
