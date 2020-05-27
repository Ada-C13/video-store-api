class VideosController < ApplicationController

  def index 
    video = Video.all.order(:id).as_json(except: [:updated_at, :created_at, :overview, :total_inventory])
    render json: video, status: :ok 
  end 

  def show 
    video = Video.find_by(id: params[:id])

    if video.nil? 
      render json: {
        "errors": [
            "Not Found"
          ]
        }, status: :not_found
      return 
    end 
    render json: video.as_json(except: [:updated_at, :created_at, :id])
  end

  def create 
    video = Video.new(video_params)
    
    if video.save 
      render json: video.as_json(only: [:id]), status: :created
      return 
    else 
      render json: {
        "errors": video.errors.messages
        }, status: :bad_request
      return 
    end 
  end 

  private 

  def video_params
     return params.permit(:title, :overview, :release_date, :total_inventory, :available_inventory)
  end 
end
