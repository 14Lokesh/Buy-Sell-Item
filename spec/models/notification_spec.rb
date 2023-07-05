# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      notification = build(:notification)
      expect(notification).to be_valid
    end

    it 'is not valid without a message' do
      notification = build(:notification, message: nil)
      expect(notification).not_to be_valid
    end
  end
end
