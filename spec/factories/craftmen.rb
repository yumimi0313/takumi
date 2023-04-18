FactoryBot.define do
  factory :craftman do
    category { 1 }
    company_name { "Craftman Company" }
    prefecture { 1 }
    manicipal { "Manicipal" }
    recruit_status { 0 }
    recruit_title { "Recruit Title" }
    recruit_content { "Recruit content text..." }
    profile { "Craftman profile text..." }
    technology { "Craftman technology" }
    image { "craftman_image.jpg" }

    association :user
  end
end