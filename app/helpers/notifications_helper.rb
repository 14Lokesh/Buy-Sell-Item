# frozen_string_literal: true

# This is a sample class representing an  Notification Helper.
module NotificationsHelper
  def send_notification_and_mail(item, current_user)
    notifications = item.user.notifications.create(message: "Name:#{current_user.username},Email:#{current_user.email} is interested in your product")
    user = item.user.id
    ActionCable.server.broadcast("notifications_#{user}", { notification: notifications })
    interested_user = current_user
    creator_email = item.user.email
    AdminMailer.interested_email(creator_email, interested_user.username, interested_user.email).deliver_later
    redirect_to product_path, notice: 'Mail and Notification have been sent to the Seller'
  end
end
