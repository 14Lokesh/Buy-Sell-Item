# rubocop:disable all
require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let(:sender_user) { create(:user) }
  let(:recipient_user) { create(:user) }
  let!(:chat) { create(:conversation, sender: sender_user, recipient: recipient_user) }
  describe 'positive context' do
    it 'can find opposed user' do
      expect(chat.opposed_user(sender_user)).to eq(recipient_user)
      expect(chat.opposed_user(recipient_user)).to eq(sender_user)
    end
    
    it 'returns the recipient for the sender' do
      expect(chat.opposed_user(sender_user)).to eq(recipient_user)
    end

    it 'returns the sender for the recipient' do
      expect(chat.opposed_user(recipient_user)).to eq(sender_user)
    end
  end
  
  describe 'negative context' do
    let(:sender_user) { create(:user) }
    let(:recipient_user) { create(:user) }
  
    it 'is invalid without a sender' do
      chat = build(:conversation, sender: nil, recipient: recipient_user)
      expect(chat).not_to be_valid
      expect(chat.errors[:sender]).to include("must exist")
    end
    
    it 'is invalid without a recipient' do
      chat = build(:conversation, sender: sender_user, recipient: nil)
      expect(chat).not_to be_valid
      expect(chat.errors[:recipient]).to include("must exist")
    end
  end

  describe '.between' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }

    let!(:chat1) { create(:conversation, sender: user1, recipient: user2) }
    let!(:chat2) { create(:conversation, sender: user2, recipient: user1) }
    let!(:chat3) { create(:conversation, sender: user1, recipient: user3) }

    it 'returns conversations between two users in any direction' do
      expect(Conversation.between(user1, user2)).to match_array([chat1, chat2])
      expect(Conversation.between(user2, user1)).to match_array([chat1, chat2])
    end
  end
    
  describe 'associations' do
    it 'is valid with valid sender and recipient' do
      expect(chat).to be_valid
    end

    it 'has an associated sender' do
      expect(chat.sender).to eq(sender_user)
    end

    it 'has an associated recipient' do
      expect(chat.recipient).to eq(recipient_user)
    end

    it 'destroys associated messages when chat is destroyed' do
      create(:message, conversation: chat)
      create(:message, conversation: chat)

      expect { chat.destroy }.to change(Message, :count).by(-2)
    end
  end
end
  

