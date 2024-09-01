class ApplicationMailer < ActionMailer::Base
  default from: ENV_SETTINGS[:action_mailer][:smtp_settings][:user_name]
  layout "mailer"
end
