# frozen_string_literal: true
# rubocop:disable all
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without a username' do
      user = build(:user, username: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid with a too long username' do
      user = build(:user, username: 'a' * 31)
      expect(user).not_to be_valid
    end

    it 'is not valid with a too long email' do
      user = build(:user, email: 'a' * 101 + '@example.com')
      expect(user).not_to be_valid
    end

    it 'is not valid with an invalid email format' do
      user = build(:user, email: 'invalid_email')
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      create(:user, email: 'lokesh@example.com')
      user = build(:user, email: 'lokesh@example.com')
      expect(user).not_to be_valid
    end

    it 'is not valid without a password digest' do
      user = build(:user, password_digest: nil)
      expect(user).not_to be_valid
    end
  end
end
