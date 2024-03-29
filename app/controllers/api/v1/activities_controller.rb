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

          json_response = @activities_by_day.map do |day, activities|
            { day: day, activities: activities }
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
          render json: @activity, status: :created, location: @activity
        else
          render json: @activity.errors, status: :unprocessable_entity
        end
      end
    
      # PATCH/PUT /activities/1
      def update
        if @activity.update(activity_params)
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
          params.permit(:title, :image, :date, :time, :speakers_name, :speakers_job, :activity_type_id)
        end
      end
  end
end
  