# frozen_string_literal: true

# This is a sample class representing an  Session controller.
class SessionsController < ApplicationController
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
    user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    cookies.signed[:user_id] = user.id
    redirect_to items_path, flash: { notice: 'Logged in successfully' }
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

  def authenticate_user(user)
    user&.authenticate(params[:password])
  end

  def redirect_to_existing_user_or_create_new(user, u_id, user_name, user_email)
    if user
      redirect_to items_path(user)
    else
      User.create(uid: u_id, name: user_name, email: user_email)
    end
    redirect_to items_path, flash: { notice: 'Logged in successfully' }
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
