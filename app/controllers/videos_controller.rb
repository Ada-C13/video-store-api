class VideosController < ApplicationController
  
  def index 
    videos = Video.all.order(:title)
    
    
    render json: vidoes.as_json(only: [:id, :title, :release_date, :available_inventory, :total_inventory, :overview]),
    status: :ok
  end 
end
