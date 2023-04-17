require 'rails_helper'

RSpec.feature "RailsAdmin", type: :feature do
  let(:admin) { create(:user, :admin) }
  # let(:user) { create(:user) }

  describe 'admin access' do
    context 'when admin logs in' do
      before do
        visit new_user_session_path
        fill_in 'user_email', with: admin.email
        fill_in 'user_password', with: admin.password
        click_button 'Log in'
        visit rails_admin_path
      end

      it 'allows access to RailsAdmin' do
        expect(current_path).to eq rails_admin_path
        expect(page).to have_content('サイト管理')
      end
    end
  end
end