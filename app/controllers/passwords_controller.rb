# frozen_string_literal: true
class PasswordsController < ApplicationController
  before_action :require_user_logged_in!
  def edit
    @user = User.find(params[:id])
    # @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if user_params[:password].blank? 
      render :edit 
    else @user.update(user_params)
      redirect_to root_path, notice: "password updated"
  
    end
  end

  private

  def user_params
    params.require(:user).permit(:password , :password_confirmation)
  end


end
