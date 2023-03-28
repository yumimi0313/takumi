class CreateCraftmen < ActiveRecord::Migration[6.1]
  def change
    create_table :craftmen do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :category
      t.string :company_name
      t.integer :prefecture
      t.string :manicipal
      t.integer :recruit_status
      t.string :recruit_title
      t.text :recruit_content
      t.text :profile
      t.text :history
      t.string :technology
      t.string :image

      t.timestamps
    end
  end
end
