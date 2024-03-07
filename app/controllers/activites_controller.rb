class ActivitiesController < ApplicationController
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
      @activity_type_name = other_params[:activity_type]
      @activity_type = ActivityType.new(title: @activity_type_name, activity: @activity)
  
      if @activity.save
        if @activity_type.save 
          render json: @activity, status: :created, location: @activity
        else
          render json: @activity_type.errors, status: :unprocessable_entity
        end
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
        params.require(:activity).permit(:title, :image, :date, :time, :speaker_name, :speaker_surname, :speaker_job, :activity_type)
      end
  
      def other_params
        params.permit(:activity_type)
      end
end
  