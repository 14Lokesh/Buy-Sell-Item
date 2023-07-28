# frozen_string_literal: true

# This is a sample class representing an  User Mailer.
class UserMailer < ApplicationMailer
  def password_reset_instructions(user)
    @user = user
    mail(to: @user.email, subject: 'Password Reset Instructions')
  end
end
