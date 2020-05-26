class VideosController < ApplicationController

  def index 
    video = Video.all.as_json(except: [:updated_at, :created_at])
    render json: video, status: :ok 
  end 

  def show 
    video = Video.find_by(id: params[:id])
    if video.nil? 
      render json: {
        ok: false, 
        message: 'Not found'
      }, status: :not_found
      return 

    end 

    render json: video.as_json(except: [:updated_at, :created_at])
  end

  def create 
    # video = Video.new 


    # return a hash with the video ID, too 

    # render json: video.as_json(except: [:updated_at, :created_at]), status: :created
  end 
  
  
end
