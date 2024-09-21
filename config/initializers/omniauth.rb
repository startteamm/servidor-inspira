
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV_SETTINGS['google_client_key'],   ENV_SETTINGS['google_client_secret']
end

OmniAuth.config.allowed_request_methods = [:post]