class VideosController < ApplicationController
  def index
  
    videos = Video.all.order(:id)

    render json: videos.as_json(only: [:id, :title, :overview, :release_date, :total_inventory, :available_inventory]), 
                              status: :ok

  end


  def show
  end

  def create
  end
end
