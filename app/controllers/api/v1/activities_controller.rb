module Api
  module V1
  class ActivitiesController < ApiController
      before_action :set_activity, only: %i[ show update destroy ]
    
      # GET /activities
      def index
        @activities = Activity.all
    
        render json: @activities
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
  