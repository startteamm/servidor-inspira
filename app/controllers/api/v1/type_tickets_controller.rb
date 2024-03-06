module Api
  module V1
    class TypeTicketsController < ApplicationController
      before_action :set_type_ticket, only: %i[show update destroy]

      def index
        render(json: TypeTicket.all)
      end

      def show
        render(json: @type_ticket)
      end

      def create
        type_ticket = TypeTicket.new(params_type_ticket)
        
        if type_ticket.save
          render(json: type_ticket, status: :created)
        else
          render(json: type_ticket.errors, status: :unprocessable_entity)
        end
      end

      def update
        if @type_ticket.update(params_type_ticket)
          render(json: @type_ticket)
        else
          render(json: @type_ticket.errors, status: :unprocessable_entity)
        end
      end

      def destroy
        @type_ticket.destroy
      end

      private

      def set_type_ticket
        @type_ticket = TypeTicket.find(params[:id])
      end

      def params_type_ticket
        params.permit(:name, :description, :value)
      end
    end
  end
end