require 'rails_helper'

RSpec.feature "ConversationsAndMessages", type: :feature do
  let(:sender) { FactoryBot.create(:user) }
  let(:recipient) { FactoryBot.create(:user) }
  let(:craftman) { FactoryBot.create(:craftman, user: recipient) }

  before do
    # Log in as the sender
    visit new_user_session_path
    fill_in 'user_email', with: sender.email
    fill_in 'user_password', with: sender.password
    click_button 'Log in'
  end

  describe "creating a new conversation and sending the first message" do
    it "creates a conversation and sends the first message" do
      visit craftman_path(craftman)
      click_link "メッセージを送る"
      wait 5

      fill_in "message_body", with: "Hello there!"

      click_link "メッセージを送る"

      expect(page).to have_content("Conversation started")
      expect(page).to have_content("Hello there!")
    end
  end

  describe "sending a new message within an existing conversation" do
    let(:conversation) { FactoryBot.create(:conversation, sender: sender, recipient: recipient) }

    it "sends a message" do
      visit conversation_messages_path(conversation)
      fill_in "message_body", with: "Hello, how are you?"
      find('a', text: 'メッセージを送る').click

      click_link "メッセージを送る"

      expect(page).to have_content("Message sent")
      expect(page).to have_content("Hello, how are you?")
    end
  end

  describe "marking a message as read" do
    let(:conversation) { FactoryBot.create(:conversation, sender: sender, recipient: recipient) }
    let!(:message) { FactoryBot.create(:message, conversation: conversation, user: sender, read: false) }

    it "marks the message as read when viewed by the recipient" do
      # Log out as sender and log in as recipient
      click_link "ログアウト"
      visit new_user_session_path
      fill_in 'user_email', with: recipient.email
      fill_in 'user_password', with: recipient.password
      click_button 'Log in'

      visit conversation_messages_path(conversation)
      message.reload

      expect(message.read).to be true
    end
  end
end
