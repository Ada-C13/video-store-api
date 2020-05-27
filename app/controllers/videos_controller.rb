class VideosController < ApplicationController
  def index
  
    videos = Video.all.order(:id)

    render json: videos.as_json(only: [:id, :title, :overview, :release_date, :total_inventory, :available_inventory]), 
                              status: :ok

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

    render json: video.as_json(only: [:id, :title, :overview, :release_date, :total_inventory, :available_inventory]), 
    status: :ok
  end

  def create
  end
end
