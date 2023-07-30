# frozen_string_literal: true

# This is a sample class representing an  Message controller.
class MessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.sender = current_user
    @message.recipient = @conversation.opposed_user(current_user)
    if @message.save
      broadcast_message
    else
      render 'conversations/show'
    end
  end

  private

  def broadcast_message
    ActionCable.server.broadcast("chat_#{@conversation.id}", {
                                   sender: @message.sender.email,
                                   message: @message.body
                                 })
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
