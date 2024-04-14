class ConfirmationMailer < Devise::Mailer
    def confirmation_instructions(record, token, opts={})
        opts[:subject] = "Ative sua conta"
        opts[:from] = 'Inspira Design <naoresponda.inspiradesign@gmail.com>'
        super
    end
end