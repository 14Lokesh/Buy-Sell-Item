# frozen_string_literal: true

# This is a sample class representing an  Conversation controller.
class ConversationsController < ApplicationController
  before_action :require_user_logged_in!
  before_action :restrict_user, only: [:show]
  def index
    @conversations = current_user.sent_conversations.or(current_user.received_conversations)
  end

  def create
    recipients = User.find(params[:conversation][:recipient_id])
    conversation = Conversation.between(current_user, recipients).first
    conversation ||= Conversation.create(sender: current_user, recipient: recipients)
    redirect_to conversation
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
  end

  private

  # def restrict_user
  #   @user = Conversation.find(params[:id])
  #   if @user.sender_id != current_user.id && @user.recipient_id != current_user.id
  #   redirect_to root_path, notice: 'you are authorized not for this conversation'
  #   end
  # end
  def restrict_user
    @user = Conversation.find(params[:id])
    redirect_unauthorized unless authorized_user?
  end

  def authorized_user?
    @user.sender_id == current_user.id || @user.recipient_id == current_user.id
  end

  def redirect_unauthorized
    redirect_to root_path, notice: 'You are not authorized for this conversation'
  end

end
