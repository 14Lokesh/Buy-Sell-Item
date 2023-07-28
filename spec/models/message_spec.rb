# rubocop: disable all

require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:conversation) { create(:conversation) }
  let(:sender) { create(:user) }
  let(:recipient) { create(:user) }

  describe 'positive context' do
    it 'is valid with valid attributes' do
      message = build(:message, conversation: conversation, sender: sender, recipient: recipient)
      expect(message).to be_valid
    end

    it 'is valid when read is true' do
      message = build(:message, :read, conversation: conversation, sender: sender, recipient: recipient)
      expect(message).to be_valid
      expect(message.read).to eq(true)
    end

    it 'is valid when read is false' do
      message = build(:message, :unread, conversation: conversation, sender: sender, recipient: recipient)
      expect(message).to be_valid
      expect(message.read).to eq(false)
    end
  end

  describe 'negative context' do
    it 'is invalid without a body' do
      message = build(:message, body: nil, conversation: conversation, sender: sender, recipient: recipient)
      expect(message).not_to be_valid
      expect(message.errors[:body]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'is invalid without a conversation' do
      message = build(:message, conversation: nil, sender: sender, recipient: recipient)
      expect(message).not_to be_valid
      expect(message.errors[:conversation]).to include("must exist")
    end

    it 'is invalid without a sender' do
      message = build(:message, sender: nil, conversation: conversation, recipient: recipient)
      expect(message).not_to be_valid
      expect(message.errors[:sender]).to include("must exist")
    end

    it 'is invalid without a recipient' do
      message = build(:message, recipient: nil, conversation: conversation, sender: sender)
      expect(message).not_to be_valid
      expect(message.errors[:recipient]).to include("must exist")
    end
  end
end
