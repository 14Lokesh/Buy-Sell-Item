# frozen_string_literal: true

# This is a sample class representing an  Conversation Helper.
module ConversationsHelper
  def authorized_user?
    @user.sender_id == current_user.id || @user.recipient_id == current_user.id
  end

  def redirect_unauthorized
    redirect_to root_path, notice: 'You are not authorized for this conversation'
  end

  def opposed_user(user)
    user == sender ? recipient : sender
  end

  def self.between(senders, recipients)
    where(sender: senders, recipient: recipients).or(where(sender: recipients, recipient: senders))
  end
end
