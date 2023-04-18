require 'rails_helper'

RSpec.feature "CraftmanCRUD", type: :feature do
  describe "creating a new craftman" do
    let(:user) { FactoryBot.create(:user) }
    before do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'

      visit new_craftman_path
      select "稲作", from: "craftman_category"
      fill_in "craftman_company_name", with: "Test Company"
      select "東京都", from: "craftman_prefecture"
      fill_in "craftman_manicipal", with: "Shinjuku"
      select "公開", from: "craftman_recruit_status"
      fill_in "craftman_recruit_title", with: "Test Title"
      fill_in "craftman_recruit_content", with: "Test Content"
      fill_in "craftman_profile", with: "Test Profile"
      fill_in "craftman_technology", with: "Ruby, Rails"
      # 画像ファイルのアップロード
      attach_file "craftman_images", Rails.root.join("spec/files/test_image.jpg")

      click_button "登録する"
    end

    it "creates a craftman" do
      expect(page).to have_content("Test Company")
      expect(page).to have_content("Test Title")
    end
  end

  describe "working with existing craftmen" do
    let(:user) { FactoryBot.create(:user) }
    let(:craftman) { FactoryBot.create(:craftman, user: user) }
    before do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
    end

    context "reading a craftman" do
      it "displays the craftman's information" do
        visit craftman_path(craftman)

        expect(page).to have_content(craftman.company_name)
        expect(page).to have_content(craftman.recruit_title)
      end
    end
    
    context "updating a craftman" do
      before do
        visit edit_craftman_path(craftman)

        fill_in "craftman_company_name", with: "Updated Company"
        fill_in "craftman_manicipal", with: "Yokohama"
        fill_in "craftman_recruit_title", with: "Updated Title"
        click_button "登録する"
      end

      it "updates the craftman" do
        expect(page).to have_content("Updated Company")
        expect(page).to have_content("Updated Title")
      end
    end

    context "deleting a craftman" do
      it "deletes the craftman" do
        visit craftman_path(craftman) 
        expect { click_link "削除" }.to change(Craftman, :count).by(-1)
        expect(page).to have_content("削除しました")
      end
    end
  end
end
