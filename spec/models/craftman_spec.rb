require 'rails_helper'

RSpec.describe Craftman, type: :model do
  let(:craftman) { build(:craftman) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(craftman).to be_valid
    end

    it "is not valid without a category" do
      craftman.category = nil
      expect(craftman).not_to be_valid
    end

    it "is not valid without a company_name" do
      craftman.company_name = nil
      expect(craftman).not_to be_valid
    end

    it "is not valid with a company_name longer than 255 characters" do
      craftman.company_name = "a" * 256
      expect(craftman).not_to be_valid
    end

    it "is not valid without a prefecture" do
      craftman.prefecture = nil
      expect(craftman).not_to be_valid
    end

    it "is not valid without a manicipal" do
      craftman.manicipal = nil
      expect(craftman).not_to be_valid
    end

    it "is not valid with a manicipal longer than 50 characters" do
      craftman.manicipal = "a" * 51
      expect(craftman).not_to be_valid
    end

    it "is not valid without a recruit_status" do
      craftman.recruit_status = nil
      expect(craftman).not_to be_valid
    end

    it "is valid with a technology shorter than or equal to 255 characters" do
      craftman.technology = "a" * 255
      expect(craftman).to be_valid
    end

    it "is not valid with a technology longer than 255 characters" do
      craftman.technology = "a" * 256
      expect(craftman).not_to be_valid
    end
  end

  describe "associations" do
    it "should belong to user" do
      expect(Craftman.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "should have many attached images" do
      expect(craftman.images).to be_an_instance_of(ActiveStorage::Attached::Many)
    end
  end
end
