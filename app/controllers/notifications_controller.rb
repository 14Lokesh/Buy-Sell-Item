# frozen_string_literal: true
class NotificationsController < ApplicationController
    before_action :require_user_logged_in!

    def interested
      category = Item.find(params[:id])
      notifications = category.user.notifications.create(message: "Interested:  Name-#{current_user.username} , Email-#{current_user.email} ")
      user = category.user.id
      ActionCable.server.broadcast("notifications_#{user}", { notification: notifications })

    end
  
    def count
      @count = current_user.notifications.where(read: false).count
      render json: { count: @count }
    end
  
    def mark_read
      Notification.where(read: false, user_id: current_user.id).update(read: true)
      redirect_to approved_ad_path
    end
  end
  