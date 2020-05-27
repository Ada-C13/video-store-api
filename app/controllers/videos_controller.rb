class VideosController < ApplicationController

  def index
    videos = Video.all.as_json(only: [:id, :title, :release_date, :available_inventory, :overview, :total_inventory])
    render json: videos, status: :ok
  end

  def show
    video = Video.find_by(id:params[:id])
    if video 
      render json: video.as_json(only: [:id, :title, :release_date, :available_inventory, :overview, :total_inventory]), status: :ok
      return
    else 
      render json: {ok: false, errors: ["Not Found"]}, status: :not_found
      return
    end
  end

  def create
    video = Video.new(video_params)
    if video.save
      render json: video.as_json, status: :created
      return
    else
      render json: {ok: false, errors: video.errors.messages}, status: :bad_request
      return
    end
  end

  private
  def video_params
    params.require(:video).permit(:title, :release_date, :available_inventory, :overview, :total_inventory)
  end
end


