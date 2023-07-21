# frozen_string_literal: true

# This is a sample class representing an  User Helper.
module UsersHelper
  def log_in_user(user)
    session[:user_id] = user.id
  end

  def authenticate_user(user)
    user&.authenticate(params[:password])
  end

  def find_or_create_user
    auth_data = request.env['omniauth.auth']
    User.find_or_create_by(uid: auth_data[:uid], provider: auth_data[:provider]) do |u|
      u.username = auth_data[:info][:first_name]
      u.email = auth_data[:info][:email]
      u.password = SecureRandom.hex(15)
    end
  end

  def process_user(user)
    if user.valid?
      user_session(user)
      redirect_to items_path, flash: { notice: 'Logged in successfully' }
    else
      redirect_to new_session_path
    end
  end

  def user_session(user)
    session[:user_id] = user.id
    cookies.signed[:user_id] = user.id
  end

  def redirect_to_existing_user_or_create_new(user, uid, user_name, user_email)
    if user
      redirect_to root_path(user)
    else
      User.create(uid:, name: user_name, email: user_email)
    end
    redirect_to root_path
  end
end
