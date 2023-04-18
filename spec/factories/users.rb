FactoryBot.define do
  factory :user do
    name { "User Name" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
    role { 0 }

    transient do
      create_craftman { true }
      create_candidate { false }
    end

    after(:create) do |user, evaluator|
      if evaluator.create_craftman && user.craftman.blank?
        create(:craftman, user: user)
      elsif evaluator.create_candidate && user.candidate.blank?
        create(:candidate, user: user)
      end
    end

    trait :candidate do
      role { 1 }
      create_craftman { false }
      create_candidate { true }
    end

    trait :admin do
      role { 2 }
      create_craftman { false }
      create_candidate { false }
    end
  end
end
