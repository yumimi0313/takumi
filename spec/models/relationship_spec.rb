require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:follower) { create(:user) }
  let(:followed) { create(:user) }
  let(:relationship) { create(:relationship, follower: follower, followed: followed) }

  describe "associations" do
    it "belongs to followed" do
      expect(relationship.followed).to eq(followed)
    end

    it "belongs to follower" do
      expect(relationship.follower).to eq(follower)
    end
  end

  describe "validations" do
    it "is valid with valid attributes" do
      expect(relationship).to be_valid
    end

    it "is invalid without a follower_id" do
      relationship.follower_id = nil
      expect(relationship).not_to be_valid
    end

    it "is invalid without a followed_id" do
      relationship.followed_id = nil
      expect(relationship).not_to be_valid
    end
  end
end
