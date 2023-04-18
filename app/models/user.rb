class User < ApplicationRecord
  #devise
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :craftman, dependent: :destroy
  has_many :products, dependent: :destroy
  has_one :candidate, dependent: :destroy   
  enum role: { craftman: 0, candidate: 1,  admin: 2 }
  
  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy 
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :encrypted_password, presence: true, length: { minimum: 6, maximum: 255 }
  validates :role, presence: true
  
  #指定のユーザをフォローする
  def follow!(other_user)
    return if following?(other_user)

    active_relationships.create!(followed_id: other_user.id)
  end

  #フォローしているかどうかを確認する
  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
end
