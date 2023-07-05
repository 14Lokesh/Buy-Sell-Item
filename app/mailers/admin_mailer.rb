# frozen_string_literal: true

# This is a sample class representing an  Admin Mailer.
class AdminMailer < ApplicationMailer
  default from: 'lokeshkumarchaman@gmail.com'

  def interested_email(creator_email , interested_username, interested_user_email)
    @interested_username = interested_username
    @interested_user_email = interested_user_email
    mail(to: creator_email, subject: 'User Interest')
  end
end
