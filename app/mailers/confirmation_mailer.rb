class ConfirmationMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts={})
    opts[:subject] = "Ative sua conta"
    opts[:from] = ENV_SETTINGS[:action_mailer][:smtp_settings][:user_name]
    super
  end
end
