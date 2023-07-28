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
  
  describe 'associations' do
    it 'has many items' do
      association = described_class.reflect_on_association(:items)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many notifications' do
      association = described_class.reflect_on_association(:notifications)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many reviews' do
      association = described_class.reflect_on_association(:reviews)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many sent_conversations' do
      association = described_class.reflect_on_association(:sent_conversations)
      expect(association.macro).to eq :has_many
      expect(association.options[:class_name]).to eq 'Conversation'
      expect(association.options[:foreign_key]).to eq 'sender_id'
    end

    it 'has many received_conversations' do
      association = described_class.reflect_on_association(:received_conversations)
      expect(association.macro).to eq :has_many
      expect(association.options[:class_name]).to eq 'Conversation'
      expect(association.options[:foreign_key]).to eq 'recipient_id'
    end
  end

  describe '#generate_reset_password_token' do
    it 'generates a reset password token and sets the expiration time' do
      user = build(:user)
      user.generate_reset_password_token

      expect(user.reset_password_token).not_to be_nil
      expect(user.reset_password_token_expires_at).to be_within(1.hour).of(1.hour.from_now)
    end
  end

  describe '#password_reset_token_valid?' do
    it 'returns true if the token is valid' do
      user = build(:user)
      user.generate_reset_password_token

      expect(user.password_reset_token_valid?).to eq(true)
    end

    it 'returns false if the token is expired' do
      user = build(:user)
      user.generate_reset_password_token
      user.reset_password_token_expires_at = 1.hour.ago

      expect(user.password_reset_token_valid?).to eq(false)
    end

    it 'returns false if the token is nil' do
      user = build(:user)

      expect(user.password_reset_token_valid?).to eq(false)
    end
  end
end
