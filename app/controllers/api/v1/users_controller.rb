module Api
  module V1
    class UsersController < ApiController
      before_action :set_user, only: %i[tickets]

      # mock
      def tickets
        tickets_serializer = []
        @user.tickets.each do |ticket|
          type_ticket = ticket.type_ticket
          event = type_ticket.event

          tickets_serializer.push(
            {
              'id': ticket.id,
              'name_type_ticket': type_ticket.name,
              'name_event': event.name,
              'address_event': event.address
            }
          )
        end

        render(json: tickets_serializer)
      end

      private

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
