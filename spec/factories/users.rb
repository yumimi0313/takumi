FactoryBot.define do
  factory :user do
    name { "User Name" }
    email { "user@example.com" }
    password { "password" }
    role { 0 }
    
    transient do
      create_craftman { true }
    end

    after(:create) do |user, evaluator|
      if evaluator.create_craftman
        create(:craftman, user: user)
      end
    end

    trait :admin do
      role { 2 }
      create_craftman { false }
    end
  end
end

# FactoryBot.define do
#   factory :user do
#     name { "User Name" }
#     email { "user@example.com" }
#     password { "password" }
#     role { 0 }
    
#     association :craftman

#     trait :admin do
#       role { 2 }
#     end
#   end
# end

# FactoryBot.define do
#   factory :craftman do
#     category { 1 }
#     company_name { "Craftman Company" }
#     prefecture { 1 }
#     manicipal { "Manicipal" }
#     recruit_status { 1 }
#     recruit_title { "Recruit Title" }
#     recruit_content { "Recruit content text..." }
#     profile { "Craftman profile text..." }
#     technology { "Craftman technology" }
#     image { "craftman_image.jpg" }

#     association :user
#   end
# end

# FactoryBot.define do
#   factory :product do
#     name { "Product Name" }
#     description { "Product description text..." }
#     image { "product_image.jpg" }
#     association :user
#   end
# end