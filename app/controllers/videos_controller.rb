class VideosController < ApplicationController

  def index
    videos = Video.all
    render json: videos.as_json(only: [:id, :title, :overview, :release_date, :total_inventory, :available_inventory]),
      status: :ok
   end      
  

  def create
    video = Video.new(video_params)
    if video.save
      render json: vidoe.as_json(only: [:id]), status: :created
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

    if video.nil?
      render json: {
        ok: false,
        messages: "not found"
      }, status: :not_found
      return
      else
    render json: video.as_json(only: [:id, :title, :overview, :release_date, :total_inventory, :available_inventory]),
      status: :ok
      return
  end



  private

  def video_params
    return params.require(:video).permit(:title, :overview, :release_date, :total_inventory, :available_inventory)
  end
end 
end
