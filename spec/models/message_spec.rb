# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      message = build(:message)
      expect(message).to be_valid
    end

    it 'is not valid without a body' do
      message = build(:message, body: nil)
      expect(message).not_to be_valid
    end
  end
end
