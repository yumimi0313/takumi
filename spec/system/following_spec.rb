# spec/system/following_spec.rb
require 'rails_helper'

RSpec.describe 'Following', type: :system do
  describe "Following" do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }

    before do
      # Log in as user
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
    end

    context 'when following another user' do
      it 'follows the user' do
        visit user_path(other_user)
        click_button 'commit'
        expect(user.following?(other_user)).to be_truthy
      end
    end

    context 'when unfollowing a followed user' do
      before do
        user.follow!(other_user)
      end

      it 'unfollows the user' do
        visit user_path(other_user)
        click_button 'commit'
        expect(user.following?(other_user)).to be_falsey
      end
    end
  end
end
