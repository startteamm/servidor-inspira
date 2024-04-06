module MercadoPago
  class Payments
    URL = 'https://api.mercadopago.com/v1/payments'.freeze
    ACESS_TOKEN = ENV['ACESS_TOKEN']
    TIME_EXPIRATION_PIX = 30

    def initialize(payment)
      @payment = payment
      @payer = payment.user
    end

    def create_payment_cartao(params_card)
      integragador(
        {
          'transaction_amount': @payment.type_ticket.value,
          'description': @payment.type_ticket.name,
          'token': params_card[:card_token],
          'payment_method_id': params_card[:payment_method_id],
          'installments': 1,
          'payer': body_payer
        }
      )
    end

    def create_payment_pix
      integragador(
        {
          'transaction_amount': @payment.type_ticket.value,
          'date_of_expiration': date_of_expiration_pix,
          'description': @payment.type_ticket.name,
          'payment_method_id': 'pix',
          'payer': body_payer
        }
      )
    end

    private

    def integragador(formatted_body)
      header = {
        'Content-Type': 'application/json',
        'X-Idempotency-Key': @payment['x_idempotency_key'],
        'Authorization': "Bearer #{ACESS_TOKEN}"
      }

      response = RestClient.post(URL, formatted_body.to_json, header)
      [response.code, response]
    rescue RestClient::Exception => e
      response = e
      [response.http_code, response.http_body]
    ensure
      @payment.response = response
    end

    def body_payer
      {
        "email": @payer.email,
        "identification": {
          'type': 'CPF',
          'number': @payer.cpf
        }
      }
    end

    def date_of_expiration_pix
      TIME_EXPIRATION_PIX.minutes.from_now.strftime('%Y-%m-%dT%H:%M:%S.%L%:z')
    end
  end
end
