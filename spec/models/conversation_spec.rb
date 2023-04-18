require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let(:sender) { create(:user) }
  let(:recipient) { create(:user) }
  let!(:conversation) { create(:conversation, sender: sender, recipient: recipient) }

  describe "associations" do
    it "belongs to sender" do
      expect(conversation.sender).to eq(sender)
    end

    it "belongs to recipient" do
      expect(conversation.recipient).to eq(recipient)
    end

    it "has many messages" do
      message1 = FactoryBot.create(:message, conversation: conversation)
      message2 = FactoryBot.create(:message, conversation: conversation)
      expect(conversation.messages).to include(message1, message2)
    end
  end

  describe "validations" do
    it "validates uniqueness of sender_id scoped to recipient_id" do
      invalid_conversation = build(:conversation, sender: sender, recipient: recipient)
      expect(invalid_conversation).not_to be_valid
    end
  end

  describe "scopes" do
    let(:other_sender) { create(:user) }
    let(:other_recipient) { create(:user) }
    let!(:conversation2) { FactoryBot.create(:conversation, sender: other_sender, recipient: recipient) }
    let!(:conversation3) { FactoryBot.create(:conversation, sender: other_sender, recipient: other_recipient) }
  
    it ".between returns conversations between two users" do
      expect(Conversation.between(sender.id, recipient.id)).to match_array([conversation])
    end
  end
  

  describe "#target_user" do
    it "returns the target user based on the current user" do
      expect(conversation.target_user(sender)).to eq(recipient)
      expect(conversation.target_user(recipient)).to eq(sender)
    end
  end
end
