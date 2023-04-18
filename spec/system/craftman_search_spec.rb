# spec/system/craftman_search_spec.rb
require 'rails_helper'

RSpec.describe "Craftman search", type: :system do
  describe "craftman search" do
    let!(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:craftman1) { create(:craftman, user: user, company_name: "Craftman One", prefecture: Craftman.prefectures[:北海道], category: Craftman.categories[:野菜生産], manicipal: "キロロ市", recruit_status: Craftman.recruit_statuses[:公開]) }
    let!(:craftman2) { create(:craftman, user: user2, company_name: "Craftman Two", prefecture: Craftman.prefectures[:青森県], category: Craftman.categories[:稲作], manicipal: "奥入瀬市", recruit_status: Craftman.recruit_statuses[:公開]) }
    
    before do
      # Log in as user
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'

      visit craftmen_path
    end

    context "searching" do
      it "searches for craftmen by company name" do
 
        fill_in "q[company_name_or_recruit_title_or_recruit_content_or_profile_or_technology_cont]", with: "Craftman One"
        click_button "検索"

        expect(page).to have_content("Craftman One")
        expect(page).not_to have_content("Craftman Two")
      end

      it "searches for craftmen by prefecture" do
        select "北海道", from: "q_prefecture_eq"
        click_button "検索"

        expect(page).to have_content("Craftman One")
        expect(page).not_to have_content("Craftman Two")
      end

      it "searches for craftmen by category" do
        select "野菜生産", from: "q[category_eq]"
        click_button "検索"

        expect(page).to have_content("Craftman One")
        expect(page).not_to have_content("Craftman Two")
      end
    end
  end
end
