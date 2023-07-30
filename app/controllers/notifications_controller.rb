# frozen_string_literal: true

# This is a sample class representing an  Notification controller.
class NotificationsController < ApplicationController
  before_action :require_user_logged_in!
  def interested
    item = Item.find(params[:id])
    send_notification_and_mail(item, current_user)
  end

  def send_notification_and_mail(item, current_user)
    messages = "Name:#{current_user.username},Email:#{current_user.email} is interested in your product"
    notifications = item.user.notifications.create(message: messages)
    user = item.user.id
    ActionCable.server.broadcast("notifications_#{user}", { notification: notifications })
    interested_user = current_user
    creator_email = item.user.email
    send_interested_email(interested_user, creator_email)
  end

  def send_interested_email(interested_user, creator_email)
    AdminMailer.interested_email(creator_email, interested_user.username, interested_user.email).deliver_later
    redirect_to product_path, flash: { notice: 'Mail and Notification has been sent to the Seller' }
  end

  def mark_read
    Notification.mark_as_read(current_user.id)
  end
end
