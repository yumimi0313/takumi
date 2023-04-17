FactoryBot.define do
  factory :user do
    name { "User Name" }
    #sequenceを使用して一意のメールアドレスを生成
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
    role { 0 }

    transient do
      create_craftman { true }
      create_candidate { false }
    end

    after(:create) do |user, evaluator|
      if evaluator.create_craftman
        create(:craftman, user: user)
      elsif evaluator.create_candidate
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
