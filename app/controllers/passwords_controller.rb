# frozen_string_literal: true

# This is a sample class representing an  Password controller.
class PasswordsController < ApplicationController
  before_action :require_user_logged_in!
  before_action :find_user, only: %i[edit update]
  def edit; end

  def update
    if user_params[:password].blank?
      render :edit
    else
      @user.update(user_params)
      redirect_to items_path, flash: { notice: 'Password Updated' }
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
