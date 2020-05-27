class VideosController < ApplicationController

  def index
    videos = Video.all.as_json(only: [:id, :title, :release_date ])
    render json: videos, status: :ok
  end
end
