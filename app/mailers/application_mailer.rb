class ApplicationMailer < ActionMailer::Base
  default to: "inspiradesignuff@gmail.com"
  default from: "naoresponda@inspiradesignuff.com"
  layout "mailer"
end
