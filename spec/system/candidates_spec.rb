require 'rails_helper'

RSpec.feature "CandidateCRUD", type: :feature do
  describe "creating a new candidate" do
    let(:user) { FactoryBot.create(:user, :candidate) }
    before do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'

      visit new_candidate_path
      select "稲作", from: "candidate_interested_category"
      fill_in "candidate_wanted_technology", with: "Ruby, Rails"
      select "東京都", from: "candidate_prefecture"
      fill_in "candidate_profile", with: "Test Profile"
      fill_in "candidate_name", with: "Test Candidate"
      attach_file "candidate_images", Rails.root.join("spec/files/test_image.jpg")

      click_button "登録する"
    end

    it "creates a candidate" do
      expect(page).to have_content("Test Candidate")
    end
  end

  describe "working with existing candidates" do
    let(:user) { FactoryBot.create(:user, :candidate) }
    let(:candidate) { FactoryBot.create(:candidate, user: user) }
    before do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
    end

    context "reading a candidate" do
      it "displays the candidate's information" do
        visit candidate_path(candidate)

        expect(page).to have_content(candidate.name)
      end
    end
    
    context "updating a candidate" do
      before do
        visit edit_candidate_path(candidate)

        fill_in "candidate_name", with: "Updated Candidate"
        fill_in "candidate_profile", with: "Updated Profile"
        click_button "登録する"
      end

      it "updates the candidate" do
        expect(page).to have_content("Updated Candidate")
        expect(page).to have_content("Updated Profile")
      end
    end

    context "deleting a candidate" do
      it "deletes the candidate" do
        visit candidate_path(candidate) 
        expect { click_link "削除" }.to change(Candidate, :count).by(-1)
        expect(page).to have_content("削除しました")
      end
    end
  end
end
