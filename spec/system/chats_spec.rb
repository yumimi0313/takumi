# spec/system/chats_spec.rb
require 'rails_helper'

RSpec.describe 'Chats', type: :system do
  describe 'Chat GPT' do
    let!(:user) { create(:user) }

    before do
      # Log in as user
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
    end

    context 'when submitting questions and answers' do
      it 'generates a text based on user inputs' do
        visit new_chat_path

        questions = [
          "あなたの事業はどの業種に属していますか？",
          "あなたが事業を始めたきっかけは何ですか？"
        ]

        answers = [
          "IT業界",
          "技術革新に興味があったから"
        ]

        # Mock chat_with_gpt method to return a predefined response
        generated_text = "プロフィール文\n後継者募集のタイトル\n商品のキャッチコピー\n商品PR文"
        allow_any_instance_of(ChatsController).to receive(:chat_with_gpt).and_return(generated_text)

        questions.each_with_index do |_, index|
          within all('.mb-3')[index] do
            fill_in "questions[][user_input]", with: answers[index]
          end
        end
        click_button '文章生成'
        

        expect(page).to have_content("プロフィール文")
        expect(page).to have_content("後継者募集のタイトル")
        expect(page).to have_content("商品のキャッチコピー")
        expect(page).to have_content("商品PR文")
      end
    end
  end
end
