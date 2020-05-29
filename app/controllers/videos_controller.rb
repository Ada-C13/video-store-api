class VideosController < ApplicationController
  def index
    videos = Video.all.as_json(only: [:id, :title, :release_date, :available_inventory])
    render json: videos.as_json, status: :ok
  end

  def create
    video = Video.new(video_params)
    if video.save
      render json: video.as_json(only: [:id]), status: :created
    else
      render json: {
        ok: false,
        error: video.errors.messages
      }, status: :bad_request
    end
  end

  def show
    video = Video.find_by(id: params[:id])
    if video
      render json: video.as_json(only: [:id, :title, :release_date, :available_inventory, :total_inventory]), status: :ok
    else
      render json: {
        ok: false,
        #errors: video.errors.messages
      }, status: :not_found
    end
  end

  private
  def video_params
    return params.require(:video).permit(:title, :overview, :release_date, :total_inventory, :available_inventory)
  end
end
