#rubocop: disable all
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
  end

  describe 'associations' do
    it 'is invalid without a user' do
      notification = build(:notification, user: nil)
      expect(notification).not_to be_valid
      expect(notification.errors[:user]).to include('must exist')
    end
  end

  describe '.mark_as_read' do
    it 'marks all notifications as read for the given user' do
      create_list(:notification, 5, user: users, read: false)

      expect{
        Notification.mark_as_read(users)
      }.to change { Notification.where(read: false, user_id: users.id).count }.from(5).to(0)
    end
  end
end
