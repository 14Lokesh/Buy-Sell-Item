# frozen_string_literal: true
#rubocop: disable all

# This is a sample class representing an  Conversation Helper.
module ConversationsHelper
  def count_chat
    count = 0
    if current_user
      conversations = current_user.sent_conversations.or(current_user.received_conversations).includes(:sender,:recipient)
      conversations.each do |conversation|
        if conversation.sender && conversation.recipient
          count += conversation.messages.where(read: false).where.not(sender_id: current_user.id).count
        end
      end
    end
    count
  end
end
