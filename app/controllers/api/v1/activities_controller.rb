module Api
  module V1
  class ActivitiesController < ApiController
      skip_before_action :authenticate_api_user!, only: [:index]
      before_action :set_activity, only: %i[ show update destroy ]
    
      # GET /activities
      def index
        # Fetch all records from the database
        @activities = Activity.all

        # Determine the reference date (you can choose any starting date)
        first_date = @activities.minimum(:date)

        if first_date.present?
          # Group the records by the day count since the reference date
          @activities_by_day = @activities.group_by do |record|
            days_since_first = (record.date - first_date).to_i
            days_since_first + 1
          end

          @activities_by_day = @activities_by_day.sort_by { |day, _| day }

          json_response = @activities_by_day.map do |day, activities|
            { day: day, activities: 
              activities.map do |activity|
                activity.as_json(include: :guests)
              end
            }
          end

          # Render each group of records in JSON format
          render json: json_response
          
        else
          render json: { error: "No activities found." }, status: :not_found
        end
      end
    
      # GET /activities/1
      def show
        render json: @activity
      end
    
      # POST /activities
      def create
        @activity = Activity.new(activity_params)
        @activity.activity_type_id = activity_params[:activity_type_id]
    
        if @activity.save
          activity_params[:guests].each do |guest_params|
            create_guest(@activity, guest_params)
          end
          render json: @activity, status: :created, location: @activity
        else
          render json: @activity.errors, status: :unprocessable_entity
        end
      end

      def create_guest(activity, params)
        @guest = Guest.new(guest_params)
        if @guest.save
          activity.guests << @guest
        else
          render json: @guest.errors, status: :unprocessable_entity
        end
      end
    
      # PATCH/PUT /activities/1
      def update
        if @activity.update(activity_params)S
          render json: @activity
        else
          render json: @activity.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /activities/1
      def destroy
        @activity.destroy!
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_activity
          @activity = Activity.find(params[:id])
        end
    
        # Only allow a list of trusted parameters through.
        def activity_params
          params.permit(:title, :description, :duration, :image, :date, :workload, :start_time,  
                        :location, :capacity, :activity_type_id, guests: [:full_name, :email, :description, :image])
        end
      end
  end
end
  