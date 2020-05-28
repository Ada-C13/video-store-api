class VideosController < ApplicationController

<<<<<<< HEAD
  def index
    videos = Video.all
    render json: videos.as_json(only: [:id, :title, :overview, :release_date, :total_inventory, :available_inventory]),
      status: :ok
   end      
  

  def create
    video = Video.new(video_params)
    if video.save
=======
  def index   

    videos = Video.order(:title).as_json(only: [:id, :title, :release_date, :available_inventory])
    render json: videos, status: :ok
        
  end

  def create
    video = Video.new(video_params)

    if video.save   
>>>>>>> f24073e9b19ae6662f3a713069d3451b34c1fea9
      render json: vidoe.as_json(only: [:id]), status: :created
      return
    else
      render json: {
    
          errors: video.errors.messages
        }, status: :bad_request
      return
    end
  end
  
  
  def show
    video = Video.find_by(id: params[:id])

    if video  
      render json: video.as_json(only: [ :title, :overview, :release_date, :total_inventory, :available_inventory])
      return
    else
      render json: {errors: ["Not Found"] }, status: :not_found
      return
  end



  private

  def video_params
    return params.permit(:title, :overview, :release_date, :total_inventory, :available_inventory)
  end
end 
end
