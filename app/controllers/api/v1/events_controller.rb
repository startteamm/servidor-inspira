module Api
  module V1
    class EventsController < ApplicationController
      before_action :set_event, only: %i[show update destroy]

      def index
        render(json: Event.all)
      end

      def show
        render(json: @event)
      end

      def create
        event = Event.new(params_event)

        if event.save
          render(json: event, status: :created)
        else
          render(json: event.errors, status: :unprocessable_entity)
        end
      end

      def update
        if @event.update(params_event)
          render(json: @event)
        else
          render(json: @event.errors, status: :unprocessable_entity)
        end
      end

      def destroy
        @event.destroy
      end

      private

      def set_event
        @event = Event.find(params[:id])
      end

      def params_event
        params.permit(:name, :description, :link, :status, :start_date, :end_date, :cep, :street,
                      :city, :neighborhood, :link_google_maps, :publico, :start_date_sale_ticket,
                      :end_date_sale_ticket)
      end
    end
  end
end