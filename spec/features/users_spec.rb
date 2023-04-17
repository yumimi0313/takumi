require 'rails_helper'

RSpec.describe "ユーザー機能", type: :system do
  describe 'ユーザー機能' do
    context 'ユーザーの新規登録した場合' do
      it 'ユーザーの新規登録ができる' do
        visit new_user_registration_path
        select '匠', from: 'user_role'
        fill_in 'user_name', with: 'test'
        fill_in 'user_email', with: 'test@test.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'Sign up'
        expect(page).to have_content '新規登録'
      end
    end
  end
  describe 'セッションのログイン機能' do
    let!(:user) { FactoryBot.create(:user) }
    before do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on 'Log in'
    end
    context 'ログインをした場合' do
      it 'ログインできる' do
        expect(page).to have_content 'ログインしました'
      end
    end
    context 'ユーザーの詳細ページにアクセスした場合' do
      it 'ユーザーの詳細ページに行ける' do
        visit user_path(user)
        expect(page).to have_content 'フォローしている人'
        expect(page).not_to have_content 'ログイン'
      end
    end
    context 'ログアウトした場合' do
      it 'ログアウトできる' do
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
        expect(page).not_to have_content 'マイページ'
      end
    end
  end
end