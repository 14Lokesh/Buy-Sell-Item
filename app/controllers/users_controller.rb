# frozen_string_literal: true

# This is a sample class representing an  User controller.
class UsersController < ApplicationController
  before_action :require_user_logged_in!, only: [:edit]
  before_action :find_user, only: %i[edit update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      cookies.signed[:user_id] = @user.id
      redirect_to items_path, flash: { notice: 'Signed Up Successfully' }
    else
      render :new
    end
  end

  def edit; end

  def update
    if user_params[:email].blank?
      render :edit
    else
      @user.update(user_params)
      redirect_to items_path, flash: { notice: 'Email Updated!!' }
    end
  end

  def profile
    @user = current_user
    @items = @user.items.where(approved: true)
    @item = Item.all
    @user_items = current_user.items.where(approved: true)
  end

  def home_page; end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
