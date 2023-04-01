class User < ApplicationRecord
  #devise
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :craftmen
  has_many :products
  has_many :candidates       

  enum role: { craftman: 0, candidate: 1,  admin: 2 }
end
