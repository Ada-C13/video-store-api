class VideosController < ApplicationController
    REQUIRED_INDEX_VIDEO_FIELDS = [:id, :title, :release_date, :available_inventory]
    REQUIRED_SHOW_VIDEO_FIELDS = [:title, :overview, :release_date, :total_inventory, :available_inventory]

    def index
        videos = Video.order(:title).as_json(only: REQUIRED_INDEX_VIDEO_FIELDS)
        render json: videos, status: :ok
    end
    
    def show
        video = Video.find_by(id: params[:id])
        if video
            render json: video.as_json(only: REQUIRED_SHOW_VIDEO_FIELDS), status: :ok
        else 
            render json: {errors: ['Not Found'] }, status: :not_found
        end
    end

    def create
        video = Video.new(video_params)
        if video.save
            render json: video.as_json(only: [:id]), status: :created
            return
        else
            render json: {errors: video.errors.messages}, status: :bad_request
            return
        end
    end

    private
    def video_params
      params.permit(:title, :overview, :release_date, :total_inventory, :available_inventory)
    end
end
