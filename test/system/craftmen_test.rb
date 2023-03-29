require "application_system_test_case"

class CraftmenTest < ApplicationSystemTestCase
  setup do
    @craftman = craftmen(:one)
  end

  test "visiting the index" do
    visit craftmen_url
    assert_selector "h1", text: "Craftmen"
  end

  test "creating a Craftman" do
    visit craftmen_url
    click_on "New Craftman"

    fill_in "Category", with: @craftman.category
    fill_in "Company name", with: @craftman.company_name
    fill_in "History", with: @craftman.history
    fill_in "Image", with: @craftman.image
    fill_in "Manicipal", with: @craftman.manicipal
    fill_in "Prefecture", with: @craftman.prefecture
    fill_in "Profile", with: @craftman.profile
    fill_in "Recruit content", with: @craftman.recruit_content
    fill_in "Recruit status", with: @craftman.recruit_status
    fill_in "Recruit title", with: @craftman.recruit_title
    fill_in "Technology", with: @craftman.technology
    fill_in "User", with: @craftman.user_id
    click_on "Create Craftman"

    assert_text "Craftman was successfully created"
    click_on "Back"
  end

  test "updating a Craftman" do
    visit craftmen_url
    click_on "Edit", match: :first

    fill_in "Category", with: @craftman.category
    fill_in "Company name", with: @craftman.company_name
    fill_in "History", with: @craftman.history
    fill_in "Image", with: @craftman.image
    fill_in "Manicipal", with: @craftman.manicipal
    fill_in "Prefecture", with: @craftman.prefecture
    fill_in "Profile", with: @craftman.profile
    fill_in "Recruit content", with: @craftman.recruit_content
    fill_in "Recruit status", with: @craftman.recruit_status
    fill_in "Recruit title", with: @craftman.recruit_title
    fill_in "Technology", with: @craftman.technology
    fill_in "User", with: @craftman.user_id
    click_on "Update Craftman"

    assert_text "Craftman was successfully updated"
    click_on "Back"
  end

  test "destroying a Craftman" do
    visit craftmen_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Craftman was successfully destroyed"
  end
end
