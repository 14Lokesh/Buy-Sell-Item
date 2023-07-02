# frozen_string_literal: true
class MessagesController < ApplicationController
    # before_action :show_data
    def create
      @conversation = Conversation.find(params[:conversation_id])
      @message = @conversation.messages.build(message_params)
      @message.sender = current_user
      @message.recipient = @conversation.opposed_user(current_user)
      if @message.save
        ActionCable.server.broadcast("chat_#{@conversation.id}", {
          sender: @message.sender.email,
          message: @message.body
        })
      else
        render 'conversations/show'
      end
    end 

    
    private
  
    def message_params
      params.require(:message).permit(:body)
    end
  end
  