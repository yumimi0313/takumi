class User < ApplicationRecord
  #devise
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :craftmen
  has_many :products
  has_many :candidates       

  enum role: { 匠: 0, 後継候補者: 1,  管理者: 2 }
end
