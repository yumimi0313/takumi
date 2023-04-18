require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:user) { create(:user) }
  let!(:product) { create(:product, user: user) }

  describe "associations" do
    it "belongs to a user" do
      expect(product.user).to eq(user)
    end

    it "has many attached images" do
      image1 = fixture_file_upload(Rails.root.join('spec', 'files', 'test_image.jpg'), 'image/jpeg')
      image2 = fixture_file_upload(Rails.root.join('spec', 'files', 'test_image2.jpg'), 'image/jpeg')
      product.images.attach(image1, image2)
      expect(product.images.count).to eq(2)
    end
  end

  describe "validations" do
    it "validates length of name" do
      valid_product = build(:product, name: 'a' * 255, user: user)
      expect(valid_product).to be_valid

      invalid_product = build(:product, name: 'a' * 256, user: user)
      expect(invalid_product).not_to be_valid
    end
  end
end
