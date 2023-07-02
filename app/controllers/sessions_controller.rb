# frozen_string_literal: true
class SessionsController < ApplicationController
  before_action :require_user_logged_in! ,only: [:mail_to_seller ,:edit]
  def new
    @user = User.all
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
        session[:user_id] = user.id
        cookies.signed[:user_id] = user.id
        redirect_to root_path , notice: "Logged in successfully"
       else
        render :new 
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

 

  def omniauth
    user = User.find_or_create_by(uid: request.env['omniauth.auth'][:uid], provider: request.env['omniauth.auth'][:provider]) do |u|
       u.username= request.env['omniauth.auth'][:info][:first_name]
       u.email = request.env['omniauth.auth'][:info][:email]
       u.password = SecureRandom.hex(15)
    end
     if user.valid?
       session[:user_id] = user.id
        redirect_to root_path
        else
        redirect_to new_session_path
      end
  end

  def facebook_login
    auth = request.env['omniauth.auth']
    uid = auth['uid']
    name = auth['info']['name']
    email = auth['info']['email']
    user = User.find_by(uid: uid)
    if user
      login(user)
    else
      user = User.create(uid: uid, name: name, email: email)
      login(user)
    end
    redirect_to root_path
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
