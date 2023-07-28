# frozen_string_literal: true

# This is a sample class representing an  User Helper.
module UsersHelper
  def log_in_user(user)
    session[:user_id] = user.id
    cookies.signed[:user_id] = user.id
  end

  def authenticate_user(user)
    user&.authenticate(params[:password])
  end

  def user_session(user)
    session[:user_id] = user.id
    cookies.signed[:user_id] = user.id
  end

  def find_user_by_email(email_id)
    User.find_by(email: email_id)
  end

  def log_in_and_redirect(user, notices)
    log_in_user(user)
    redirect_to items_path, flash: { notice: notices }
  end

  def handle_new_user(auth_data)
    user = find_or_create_user_from_omniauth(auth_data)
    user.valid? ? log_in_and_redirect(user, 'Logged in successfully') : redirect_to_new_user
  end

  def find_or_create_user_from_omniauth(auth_data)
    email_id = auth_data['info']['email']
    User.find_by(email: email_id) || create_user_from_omniauth(auth_data)
  end

  def create_user_from_omniauth(auth_data)
    User.find_or_create_by(uid: auth_data['uid'], provider: auth_data['provider']) do |u|
      u.username = auth_data['info']['first_name']
      u.email = auth_data['info']['email']
      u.password = SecureRandom.hex(15)
    end
  end

  def redirect_to_new_user
    redirect_to new_user_path, flash: { notice: 'There was a problem' }
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
