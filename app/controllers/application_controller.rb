# frozen_string_literal: true

# This is a sample class representing an Application controller.
class ApplicationController < ActionController::Base
  before_action :set_current_user
  helper_method :current_admin

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_user_logged_in!
    redirect_to new_session_path, flash: { notice: 'Kindly login' } if Current.user.nil?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def check_admin
    redirect_to root_path, flash: { notice: 'You are not an admin' } unless Current.user&.admin?
  end

  def current_admin
    @current_admin ||= User.find_by(id: session[:user_id])
  end

  def restrict_admin
    redirect_to root_path, flash: { notice: 'Admin is not allowed' } if Current.user.admin?
  end
end
