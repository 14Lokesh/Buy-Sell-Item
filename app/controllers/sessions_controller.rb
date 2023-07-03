# frozen_string_literal: true

# This is a sample class representing an  Session controller.
class SessionsController < ApplicationController
  include UsersHelper
  before_action :require_user_logged_in!, only: %i[mail_to_seller edit]
  def new
    # redirect_to root_path if Current.user
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      cookies.signed[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in successfully'
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def omniauth
    user = find_or_create_user_from_omniauth
    if user.valid?
      log_in_user(user)
      redirect_to root_path
    else
      redirect_to new_session_path
    end
  end

  def facebook_login
    auth = request.env['omniauth.auth']
    u_id = auth['uid']
    user_name = auth['info']['name']
    user_email = auth['info']['email']
    user = User.find_by(uid: u_id)
    redirect_to_existing_user_or_create_new(user, u_id, user_name, user_email)
  end

  def mail_to_seller
    item = Item.find(params[:id])
    interested_user = current_user
    creator_email = item.user.email
    AdminMailer.interested_email(creator_email, interested_user.username, interested_user.email).deliver_now
    redirect_to product_path
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
