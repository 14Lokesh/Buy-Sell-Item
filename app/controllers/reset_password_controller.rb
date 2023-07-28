# frozen_string_literal: true

# This is a sample class representing an Reset Password controller.
class ResetPasswordController < ApplicationController
  include ResetPasswordHelper
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user
      reset_password_and_send_email(user)
    else
      flash[:notice] = 'Email not found.'
      render :new
    end
  end

  def edit
    @user = User.find_by(reset_password_token: params[:reset_password_token])

    if @user&.password_reset_token_valid?
      # redirect to password reset form
    else
      redirect_to root_path, flash: { notice: 'Password reset link has expired or is invalid.' }
    end
  end

  def update
    @user = User.find_by(reset_password_token: params[:user][:reset_password_token])
    if @user&.password_reset_token_valid?
      handle_password_reset
    else
      handle_invalid_reset
    end
  end

  def handle_password_reset
    if @user.update(user_params)
      redirect_to new_session_path, flash: { notice: 'Password reset successful.' }
    else
      flash[:notice] = 'Password has not been matched'
      render :edit
    end
  end

  def handle_invalid_reset
    redirect_to new_session_path, flash: { notice: 'Password reset link has expired or is invalid.' }
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
