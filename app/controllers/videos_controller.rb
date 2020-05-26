class VideosController < ApplicationController

  def index 
    video = Video.all
    render json: video.as_json(except: [:updated_at, :created_at]), status: :ok   
  end 
  
  def show 


  end 
end
