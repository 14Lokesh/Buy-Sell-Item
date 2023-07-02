# frozen_string_literal: true
class ConversationsController < ApplicationController
    # before_action :show_data
    before_action :require_user_logged_in!
    before_action :restrict_user, only: [:show]
    def index
      @conversations = current_user.sent_conversations.or(current_user.received_conversations)
    end
  
    def create
      # binding.pry
      recipient = User.find(params[:conversation][:recipient_id])
      conversation = Conversation.between(current_user, recipient).first
      conversation ||= Conversation.create(sender: current_user, recipient: recipient)
  
      redirect_to conversation
    end
  
    def show
      @conversation = Conversation.find(params[:id])
      @message = Message.new
    end
    private

  def restrict_user
    @user = Conversation.find(params[:id])
    if @user.sender_id != current_user.id && @user.recipient_id != current_user.id
    redirect_to root_path, notice: 'you are not for this conversation'
   end
  end
  end
  