class VideosController < ApplicationController
  def index
    videos = Video.all.order(:title)
    render json: videos.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  def show
    video = Video.find_by(id: params[:id])
    if video.nil?
      render json: {
        ok: false,
        message: 'Not found',
      }, status: :not_found
      return
    end
    render json: video.as_json(except: [:created_at, :updated_at]), 
                              status: :ok
  end
end
