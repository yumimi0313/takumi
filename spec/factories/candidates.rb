FactoryBot.define do
  factory :candidate do
    association :user
    interested_category { 1 } 
    wanted_technology { "Ruby, Rails" }
    prefecture { 1 } 
    profile { "MyText" }
    image { "candidate_image.jpg" }
    name { "Test Candidate" }
  end
end
