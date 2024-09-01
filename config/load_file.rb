# Loads yml with all environment variables to be used by the entire application.
# Having a yml with all environment variables helps unify the information and make it easier to view.
ENV_SETTINGS = Rails.application.config_for(:env_settings)