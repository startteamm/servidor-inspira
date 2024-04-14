module Api
  module V1
    class UsersController < ApiController
      before_action :set_user, only: %i[tickets ticket]
      before_action :set_ticket, only: %i[ticket]

      # mocks
      def tickets
        tickets_serializer = []
        @user.tickets.each do |ticket|
          tickets_serializer.push(format_response_ticket(ticket))
        end

        render(json: tickets_serializer)
      end

      def ticket
        render(json: format_response_ticket(@ticket))
      end

      def registration_in_activities
        activity_ids = params.permit(activity_ids: [])[:activity_ids]

        return render(json: { activity_ids: "can't be empty" }, status: :unprocessable_entity) if activity_ids.blank?

        begin
          current_api_user.activity_ids = activity_ids

          render(json: current_api_user.activities)
        rescue => e
          render(json: { activity_ids: e.message.split('.').last.strip }, status: :unprocessable_entity)
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def set_ticket
        @ticket = @user.tickets.find(params[:id_ticket])
      end

      def format_response_ticket(ticket)
        type_ticket = ticket.type_ticket
        event = type_ticket.event

        {
          'id': ticket.id,
          'name_type_ticket': type_ticket.name,
          'name_event': event.name,
          'address_event': event.address
        }
      end
    end
  end
end
