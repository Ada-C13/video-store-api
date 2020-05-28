class VideosController < ApplicationController
  
  def index 
    videos = Video.all.order(:title)
    
    render json: videos.as_json(only: [:id, :title, :release_date, :available_inventory]),
    status: :ok
  end 
  
  def show
    video = Video.find_by(id: params[:id])
    
    if video.nil?
      render json: {
        errors: ['Not Found']
        }, status: :not_found
        
        return  
      end
      
      render json: video.as_json(only: [:overview, :title, :release_date, :available_inventory, :total_inventory])
    end
    
    def create 
      #TODO: Fix this!
      video = Video.new(title: params[:video][:title], release_date: params[:video][:release_date], available_inventory: params[:video][:available_inventory], total_inventory: params[:video][:total_inventory], overview: params[:video][:overview])
      
      if video.save
        render json: video.as_json(only: [:id]), status: :created
        return
      else
        render json: {
          errors: video.errors.messages
          }, status: :bad_request
          return   
        end
      end 
      
      private
      
      def video_params
        # TODO: how can we get this up in create??
        return params.permit(:title, :release_date, :available_inventory, :total_inventory, :overview)
      end
      
      
    end
    