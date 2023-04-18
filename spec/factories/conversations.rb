FactoryBot.define do
  factory :conversation do
    association :sender, factory: :user
    association :recipient, factory: :user

    # 追加: 同じ sender と recipient が作成されないようにする
    after(:build) do |conversation|
      while conversation.sender_id == conversation.recipient_id
        conversation.recipient = FactoryBot.create(:user)
      end
    end
  end
end
