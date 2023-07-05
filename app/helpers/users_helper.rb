# frozen_string_literal: true

# This is a sample class representing an  User Helper.
module UsersHelper
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
