Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials.development[:google_client_id],
           Rails.application.credentials.development[:google_client_secret]
  provider :facebook, Rails.application.credentials.development[:facebook_app_id],
           Rails.application.credentials.development[:facebook_app_secret]
end
