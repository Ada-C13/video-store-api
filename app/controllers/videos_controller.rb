class VideosController < ApplicationController

  def index
    videos = Video.order(:title).as_json(only: [:id, :title, :release_date, :available_inventory])
    render json: videos, status: :ok
  end

  def show
    video = Video.find_by(id:params[:id])
    if video 
      render json: video.as_json(only: [:title, :release_date, :available_inventory, :total_inventory, :overview]), status: :ok
      return
    else 
      render json: {errors: ["Not Found"]}, status: :not_found
      return
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
    params.permit(:title, :release_date, :available_inventory, :overview, :total_inventory)
  end
end


