require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:conversation) { create(:conversation) }
  let(:user) { create(:user) }
  let(:message) { create(:message, conversation: conversation, user: user) }

  describe "associations" do
    it "belongs to conversation" do
      expect(message.conversation).to eq(conversation)
    end

    it "belongs to user" do
      expect(message.user).to eq(user)
    end
  end

  describe "validations" do
    it "is valid with valid attributes" do
      expect(message).to be_valid
    end

    it "is invalid without a body" do
      message.body = nil
      expect(message).not_to be_valid
    end

    it "is invalid without a conversation_id" do
      message.conversation_id = nil
      expect(message).not_to be_valid
    end

    it "is invalid without a user_id" do
      message.user_id = nil
      expect(message).not_to be_valid
    end
  end

  describe "#message_time" do
    it "returns the correct message time" do
      formatted_time = message.created_at.strftime("%m/%d/%y at %l:%M %p")
      expect(message.message_time).to eq(formatted_time)
    end
  end
end
