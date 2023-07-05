# frozen_string_literal: true

# This is a sample class representing an  User Helper.
module UsersHelper
  # def find_or_create_user_from_omniauth
  #   User.find_or_create_by(uid: request.env['omniauth.auth'][:uid],
  #                          provider: request.env['omniauth.auth'][:provider]) do |u|
  #     u.username = request.env['omniauth.auth'][:info][:first_name]
  #     u.email = request.env['omniauth.auth'][:info][:email]
  #     u.password = SecureRandom.hex(15)
  #   end
  # end

  def log_in_user(user)
    session[:user_id] = user.id
  end

  def redirect_to_existing_user_or_create_new(user, uid, user_name, user_email)
    if user
      redirect_to root_path(user)
    else
      User.create(uid:, name: user_name, email: user_email)
      redirect_to root_path(user)
    end

    redirect_to root_path
  end
end
