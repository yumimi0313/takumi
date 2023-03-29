class CreateCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :candidates do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :interested_category
      t.string :wanted_technology
      t.integer :prefecture
      t.text :profile
      t.string :image

      t.timestamps
    end
  end
end
