# rubocop:disable all
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'positive context' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end
  end
  describe 'negative context' do
    it 'is invalid without a username' do
      user = build(:user, username: nil)
      expect(user).not_to be_valid
      expect(user.errors[:username]).to include("can't be blank")
    end

    it 'is invalid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is invalid with an invalid email format' do
      user = build(:user, email: 'invalid_email')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('must be a valid email address')
    end

    it 'is invalid with a duplicate email' do
      create(:user, email: 'duplicate@example.com')
      user = build(:user, email: 'duplicate@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('has already been taken')
    end

    it 'is invalid without a password' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password_digest]).to include("can't be blank")
    end
  end
end
