# frozen_string_literal: true

# This is a sample class representing an  Message Helper.
module MessagesHelper
  def broadcast_message
    ActionCable.server.broadcast("chat_#{@conversation.id}", {
                                   sender: @message.sender.email,
                                   message: @message.body
                                 })
  end
end
