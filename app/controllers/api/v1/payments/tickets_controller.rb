module Api
  module V1
    module Payments
      class TicketsController < ApiController
        before_action :set_payment, only: %i[pix cartao]
        before_action :payment_type_checker, only: %i[pix cartao]

        def start_checkout
          type_ticket = TypeTicket.find(params[:id_ticket])
          payment = type_ticket.payments.create(user: current_api_user)

          render(json: { x_idempotency_key: payment.x_idempotency_key,
                         user: current_api_user.as_json_checkout,
                         type_ticket: type_ticket.as_json_checkout
          })
        end

        def pix
          gateway = MercadoPago::Payments.new(@payment)
          response = gateway.create_payment_pix
          response_json = JSON.parse(response[1])

          return head(500) unless @payment.save

          if [200, 201].include?(response[0])
            render(json: as_json_response_pix(response_json), status: response[0])
          else
            render(json: { message: response_json['message'] }, status: response[0])
          end
        end

        def cartao
          gateway = MercadoPago::Payments.new(@payment)
          response = gateway.create_payment_cartao(params_payment_cartao)
          response_json = JSON.parse(response[1])

          return head(500) unless @payment.save

          if [200, 201].include?(response[0])
            render(json: as_json_response_cartao(response_json), status: response[0])
          else
            render(json: { message: response_json['message'] }, status: response[0])
          end
        end

        private

        def set_payment
          @payment = Payment.find_by(x_idempotency_key: params[:x_idempotency_key])

          return head(:not_found) if @payment.nil?
        end

        def payment_type_checker
          return @payment.tipo = params[:action] == 'pix' ? 0 : 1 unless @payment.response

          head(406) if @payment.tipo != params[:action] 
        end

        def params_payment_cartao
          params.permit(:card_token, :payment_method_id)
        end

        def as_json_response_pix(response_gateway_json)
          filter_response = response_gateway_json['point_of_interaction']['transaction_data']
          date = Time.zone.parse(response_gateway_json['date_of_expiration'])

          {
            "qr_code_base64": filter_response['qr_code_base64'],
            "qr_code": filter_response['qr_code'],
            "date_of_expiration": date&.strftime('%d/%m/%Y'),
            "hour_of_expiration": date&.strftime('%H:%M:%S')
          }
        end

        def as_json_response_cartao(response_gateway_json)
          { "status": response_gateway_json['status'] }
        end
      end
    end
  end
end
