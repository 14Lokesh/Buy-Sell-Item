# frozen_string_literal: true

# This is a sample class representing an  Session controller.
class SessionsController < ApplicationController
  include UsersHelper
  before_action :require_user_logged_in!, only: %i[mail_to_seller edit]
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if authenticate_user(user)
      session[:user_id] = user.id
      cookies.signed[:user_id] = user.id
      redirect_to items_path, flash: { notice: 'Logged in successfully' }
    else
      flash[:notice] = 'Invalid Email or Password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def omniauth
    user = find_or_create_user
    process_user(user)
  end

  def find_or_create_user
    auth_data = request.env['omniauth.auth']
    User.find_or_create_by(uid: auth_data[:uid], provider: auth_data[:provider]) do |u|
      u.username = auth_data[:info][:first_name]
      u.email = auth_data[:info][:email]
      u.password = SecureRandom.hex(15)
    end
  end

  def process_user(user)
    if user.valid?
      user_session(user)
      redirect_to root_path
    else
      redirect_to new_session_path
    end
  end

  def user_session(user)
    session[:user_id] = user.id
    cookies.signed[:user_id] = user.id
  end

  def facebook_login
    auth = request.env['omniauth.auth']
    u_id = auth['uid']
    user_name = auth['info']['name']
    user_email = auth['info']['email']
    user = User.find_by(uid: u_id)
    redirect_to_existing_user_or_create_new(user, u_id, user_name, user_email)
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
