# frozen_string_literal: true

# This is a sample class representing an  Conversation Helper.
module ConversationsHelper
  def authorized_user?
    @user.sender_id == current_user.id || @user.recipient_id == current_user.id
  end

  def redirect_unauthorized
    redirect_to root_path, notice: 'You are not authorized for this conversation'
  end

  def count_chat
    count = 0
    if current_user
      conversations = current_user.sent_conversations.or(current_user.received_conversations)
      conversations.each do |conversation|
        count += conversation.messages.where(read: false).where.not(sender_id: current_user.id).count
      end
    end
    count
  end
end
