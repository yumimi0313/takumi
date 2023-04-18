require 'rails_helper'

RSpec.feature "ProductCRUD", type: :feature do
  describe "creating a new product" do
    let(:user) { FactoryBot.create(:user) }
    before do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'

      visit new_product_path
      fill_in "product_name", with: "Test Product"
      fill_in "product_description", with: "Test Description"
      attach_file "product_images", Rails.root.join("spec/files/test_image.jpg")

      click_button "登録する"
    end

    it "creates a product" do
      expect(page).to have_content("Test Product")
      expect(page).to have_content("Test Description")
    end
  end

  describe "working with existing products" do
    let(:user) { FactoryBot.create(:user) }
    let(:product) { FactoryBot.create(:product, user: user) }
    before do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
    end

    context "reading a product" do
      it "displays the product's information" do
        visit product_path(product)

        expect(page).to have_content(product.name)
        expect(page).to have_content(product.description)
      end
    end
    
    context "updating a product" do
      before do
        visit edit_product_path(product)

        fill_in "product_name", with: "Updated Product"
        fill_in "product_description", with: "Updated Description"
        click_button "登録する"
      end

      it "updates the product" do
        expect(page).to have_content("Updated Product")
        expect(page).to have_content("Updated Description")
      end
    end

    context "deleting a product" do
      it "deletes the product" do
        visit product_path(product) 
        expect { click_link "削除" }.to change(Product, :count).by(-1)
        expect(page).to have_content("削除しました")
      end
    end
  end
end
