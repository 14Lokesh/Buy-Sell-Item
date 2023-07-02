class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:conversation_id]}"
  end

  def receive(data)
    Message.create(conversation_id: data['conversation_id'], sender_id: current_user.id, body: data['message'])
  end
end
