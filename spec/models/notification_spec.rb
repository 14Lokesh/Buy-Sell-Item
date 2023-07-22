# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:users) { create(:user) }

  describe 'positive context' do
    it 'is valid with valid attributes' do
      notification = build(:notification, user: users)
      expect(notification).to be_valid
    end
  end

  describe 'negative context' do
    it 'is invalid without a message' do
      notification = build(:notification, message: nil, user: users)
      expect(notification).not_to be_valid
      expect(notification.errors[:message]).to include("can't be blank")
    end

    it 'is invalid without a user' do
      notification = build(:notification, user: nil)
      expect(notification).not_to be_valid
      expect(notification.errors[:user]).to include('must exist')
    end
  end
end
