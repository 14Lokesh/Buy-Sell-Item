# frozen_string_literal: true

# This is a sample class representing an  User controller.
class UsersController < ApplicationController
  before_action :require_user_logged_in!, only: [:edit]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      cookies.signed[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if user_params[:email].blank?
      render :edit
    else
      @user.update(user_params)
      redirect_to root_path
      flash[:notice] = 'Email Updated!!'
    end
  end

  def profile
    @user = current_user
    @items = @user.items.where(approved: true)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
