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
    user = find_user_by_email(request.env['omniauth.auth']['info']['email'])
    if user
      log_in_and_redirect(user, 'Logged in successfully')
    else
      handle_new_user(request.env['omniauth.auth'])
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

  def user_params
    params.require(:user).permit(:email)
  end
end
