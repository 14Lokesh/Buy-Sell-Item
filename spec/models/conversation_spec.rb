# rubocop:disable all

require 'rails_helper'

RSpec.describe Conversation, type: :model do
    describe 'positive context' do
      let(:sender_user) { create(:user) }
      let(:recipient_user) { create(:user) }
      let!(:chat) { create(:conversation, sender: sender_user, recipient: recipient_user) }
  
      it 'is valid with valid sender and recipient' do
        expect(chat).to be_valid
      end
  
      it 'has an associated sender' do
        expect(chat.sender).to eq(sender_user)
      end
  
      it 'has an associated recipient' do
        expect(chat.recipient).to eq(recipient_user)
      end
  
      it 'can find opposed user' do
        expect(chat.opposed_user(sender_user)).to eq(recipient_user)
        expect(chat.opposed_user(recipient_user)).to eq(sender_user)
      end
  
      it 'destroys associated messages when chat is destroyed' do
        create(:message, conversation: chat)
        create(:message, conversation: chat)
  
        expect { chat.destroy }.to change(Message, :count).by(-2)
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
end
  

