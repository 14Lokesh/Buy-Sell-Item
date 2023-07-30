# frozen_string_literal: true

# This is a sample class representing an  Application Helper.
module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def show_errors(object, field_name)
    return unless object.errors.any?
    return if object.errors.messages[field_name].blank?

    object.errors.messages[field_name].join(', ')
  end

  def unread_notifications
    current_user.notifications.where(read: false)
  end
end
