# frozen_string_literal: true

# This is a sample class representing a Helper.
module ResetPasswordHelper
  def reset_password_and_send_email(user)
    user.generate_reset_password_token
    user.save
    UserMailer.password_reset_instructions(user).deliver_later
    redirect_to new_session_path, flash: { notice: 'Password reset instructions sent to your email.' }
  end
end
