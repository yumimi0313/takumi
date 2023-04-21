require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { build(:user) }

    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'is invalid if name is too long' do
      user.name = 'a' * 256
      expect(user).to_not be_valid
    end

    it 'is invalid without an email' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'is invalid if email is too long' do
      user.email = 'a' * 244 + '@example.com'
      expect(user).to_not be_valid
    end

    it 'is invalid without an password' do
      user.password = nil
      expect(user).to_not be_valid
    end

    it 'is invalid if password is too short' do
      user.password = 'a' * 5
      expect(user).to_not be_valid
    end

    it 'is invalid if password is too long' do
      user.password = 'a' * 256
      expect(user).to_not be_valid
    end

    it 'is invalid without a role' do
      user.role = nil
      expect(user).to_not be_valid
    end
  end

  describe "associations" do
    let(:craftman) { create(:craftman) }
    let(:candidate) { create(:candidate) }
    let(:product) { create(:product) }
    let(:relationship) { create(:relationship) }
  
    it "should have one craftman" do
      expect(User.reflect_on_association(:craftman).macro).to eq(:has_one)
    end
  
    it "should have one candidate" do
      expect(User.reflect_on_association(:candidate).macro).to eq(:has_one)
    end
  
    it "should have many products" do
      expect(User.reflect_on_association(:products).macro).to eq(:has_many)
    end
  
    it "should have many active_relationships" do
      expect(User.reflect_on_association(:active_relationships).macro).to eq(:has_many)
    end
  
    it "should have many following" do
      expect(User.reflect_on_association(:following).macro).to eq(:has_many)
    end
  
    it "should have many passive_relationships" do
      expect(User.reflect_on_association(:passive_relationships).macro).to eq(:has_many)
    end
  
    it "should have many followers" do
      expect(User.reflect_on_association(:followers).macro).to eq(:has_many)
    end
  end  

  describe 'instance methods' do
    let!(:user1) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user) }

    context 'follow!' do
      it 'should create a new relationship' do
        expect { user1.follow!(user2) }.to change { user1.following.count }.by(1)
      end
    end

    context 'following?' do
      it 'should return true if following' do
        user1.follow!(user2)
        expect(user1.following?(user2)).to be_truthy
      end

      it 'should return false if not following' do
        expect(user1.following?(user2)).to be_falsey
      end
    end

    context 'unfollow!' do
      it 'should destroy the relationship' do
        user1.follow!(user2)
        expect { user1.unfollow!(user2) }.to change { user1.following.count }.by(-1)
      end
    end
  end
end
