class VideosController < ApplicationController
    REQUIRED_VIDEO_FIELDS = [:id, :title, :release_date, :available_inventory]
    
    def index
        videos = Video.all.as_json(only: REQUIRED_VIDEO_FIELDS)
        render json: videos, status: :ok
    end
    
    def show
        video = Video.find_by(id: params[:id])
        if video
            render json: video.as_json(only: REQUIRED_VIDEO_FIELDS), status: :ok
        else 
            render json: { ok: false, errors: ["Not Found"] }, status: :not_found
        end
    end

    def create
        video = Video.new(video_params)
        if video.save
            render json: video.as_json(only: REQUIRED_VIDEO_FIELDS), status: :created
            return
        else
            render json: {ok: false, errors: video.errors.messages}, status: :bad_request
            return
        end
    end

    private
    def video_params
        params.require(:video).permit(:title, :overview, :release_date, :total_inventory, :available_inventory)
    end
end
