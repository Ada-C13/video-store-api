class VideosController < ApplicationController

  def index
    videos = Video.all.as_json(only: [:id, :available_inventory, :release_date, :title])
    render json: videos, status: :ok
  end


  def create
    video = Video.new(video_params)

    if video.save
      render json: video.as_json(only: [:id]), status: :created
      return
    else
      render json: {
          ok: false,
          errors: video.errors.messages
        }, status: :bad_request
      return
    end
  end


def show
    video = Video.find_by(id: params[:id])

    if video
      render json: video.as_json(only: [:id, :title, :release_date, :available_inventory])
      return
    else
      render json: { ok: false, errors: ["Not Found"] }, status: :not_found
      return
    end
  end
  

  private

  def video_params
    return params.require(:video).permit(:title, :release_date, :available_inventory)
  end

end