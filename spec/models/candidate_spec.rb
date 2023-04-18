require 'rails_helper'

RSpec.describe Candidate, type: :model do
  let(:candidate) { build(:candidate) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(candidate).to be_valid
    end

    it "is not valid without a name" do
      candidate.name = nil
      expect(candidate).to_not be_valid
    end

    it "is not valid with a name longer than 255 characters" do
      candidate.name = "a" * 256
      expect(candidate).to_not be_valid
    end

    it "is not valid without an interested_category" do
      candidate.interested_category = nil
      expect(candidate).to_not be_valid
    end

    it "is not valid with a wanted_technology longer than 255 characters" do
      candidate.wanted_technology = "a" * 256
      expect(candidate).to_not be_valid
    end

    it "is not valid without a prefecture" do
      candidate.prefecture = nil
      expect(candidate).to_not be_valid
    end
  end

  describe "associations" do
    it "should belong to a user" do
      expect(candidate.user).to be_a(User)
    end

    it "should have many attached images" do
      expect(candidate.images).to be_an_instance_of(ActiveStorage::Attached::Many)
    end
  end

  describe "enums" do
    it "defines the correct interested_category values" do
      expect(Candidate.interested_categories).to eq({
        "稲作" => 0, "野菜生産" => 1, "果物生産" => 2, "水産業" => 3, "畜産" => 4, "酪農" => 5, "食品製造" => 6, "飲食店" => 7, "工芸品製造" => 8
      })
    end
  end
end
