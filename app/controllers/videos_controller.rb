class VideosController < ApplicationController
  def index
    videos = Video.all.order(:title)

    render json: videos.as_json(except: [:created_at, :updated_at]), status: :ok
  end
end
