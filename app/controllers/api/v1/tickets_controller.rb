module Api
  module V1
    class TicketsController < ApiController
      before_action :set_ticket, only: %i[show update destroy qrcode]

      def index
        render(json: Ticket.all)
      end

      def show
        render(json: @ticket)
      end

      def create
        ticket = Ticket.new(params_ticket)

        if ticket.save
          render(json: ticket, status: :created)
        else
          render(json: ticket.errors, status: :unprocessable_entity)
        end
      end

      def update
        if @ticket.update(params_ticket)
          render(json: @ticket)
        else
          render(json: @ticket.errors, status: :unprocessable_entity)
        end
      end

      def destroy
        @ticket.destroy
      end

      def qrcode
        qrcode = RQRCode::QRCode.new(@ticket.code)

        png = qrcode.as_png(
          bit_depth: 1,
          border_modules: 1,
          color_mode: ChunkyPNG::COLOR_GRAYSCALE,
          color: 'black',
          file: nil,
          fill: 'white',
          module_px_size: 11,
          resize_exactly_to: false,
          resize_gte_to: false
        )

        render(json: { qrcode: Base64.encode64(png.to_s) })
      end

      def validar_ingresso
        @ticket = Ticket.find_by(code: params[:code])

        return head(:not_found) if @ticket.nil?

        unless @ticket.validated?
          @ticket.validar!
          return head(:ok)
        end

        render(json: { messagem: 'Ingresso já foi validado.' }, status: :bad_request)
      end

      private

      def set_ticket
        @ticket = Ticket.find(params[:id])
      end

      def params_ticket
        params.permit(:type_ticket_id, :user_id)
      end
    end
  end
end
