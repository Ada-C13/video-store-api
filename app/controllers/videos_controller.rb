class VideosController < ApplicationController
VIDEOKEYS = [:id, :title, :release_date, :available_inventory]
SHOWKEYS = [:title, :overview, :release_date, :total_inventory, :available_inventory]
  
  def index
    videos = Video.order(:title).all.as_json(only: VIDEOKEYS.sort )
    render json: videos, status: :ok
  end

  def create
    video = Video.new(video_params)
    if video.save
      render json: video.as_json(only: [:id]), status: :created
      return
    else
      puts video.errors.messages
      render json: {
          errors: video.errors.messages
        }, status: :bad_request
      return
      puts "these are the error messages #{video.errors.messages}"
    end
  end

  def show
    video = Video.find_by(id: params[:id])

    if video
      render json: video.as_json(only: SHOWKEYS.sort)
      return
    else
      render json: { errors: ['Not Found'] }, status: :not_found
      return
    end
  end
  
  private

  def video_params
    return params.permit(:title, :overview, :release_date, :total_inventory, :available_inventory)
  end
end