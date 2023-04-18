FactoryBot.define do
  factory :product do
    name { "Product Name" }
    description { "Product description" }
    image { "product_image.jpg" }
    association :user
  end
end