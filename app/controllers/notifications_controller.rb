# frozen_string_literal: true

# This is a sample class representing an  Notification controller.
class NotificationsController < ApplicationController
  before_action :require_user_logged_in!
  def interested
    category = Item.find(params[:id])
     notifications = category.user.notifications.create(message: "#{current_user.username} is totally interested in your post.")
    # notifications = Notification.new(message: "#{current_user.username} is totally interested in your post.")
    user = category.user.id
    ActionCable.server.broadcast("notifications_#{user}", { notification: notifications })
    # item = Item.find(params[:id])
    # interested_user = current_user
    # creator_email = item.user.email
    # AdminMailer.interested_email(creator_email, interested_user.username, interested_user.email).deliver_now
    redirect_to product_path, notice: 'Mail and Notification has been sent to the Seller'
  end

  def count
    @count = current_user.notifications.where(read: false).count
    render json: { count: @count }
  end

  def mark_read
    Notification.where(read: false, user_id: current_user.id).update(read: true)
    redirect_to items_path
  end
end
