module Api
    module V1
    class GuestsController < ApiController
        before_action :set_guest, only: %i[ show update destroy ]

        def index
          # Fetch all records from the database
          @guests = Guest.all

          render json: @guests
        end
      
        def show
          render json: @guest
        end
      
        def create
          @guest = Guest.new(guest_params)

          if @guest.save
            render(json: @guest, status: :created)
          else
            render json: @guest.errors, status: :unprocessable_entity
          end
        end
      
        def update
          if @guest.update(guest_params)
            render json: @guest
          else
            render json: @guest.errors, status: :unprocessable_entity
          end
        end
      
        def destroy
          @guest.destroy!
        end
      
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_guest
            @guest = Guest.find(params[:id])
          end
      
          # Only allow a list of trusted parameters through.
          def guest_params
            params.require(:guest).permit(:full_name, :email, :description, :image)
          end
        end
    end
  end
    