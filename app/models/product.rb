class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :name, length: { maximum: 255 }
end
