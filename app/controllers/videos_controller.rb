class VideosController < ApplicationController
  
  def index 
    videos = Video.all.order(:title)
    
    render json: videos.as_json(only: [:id, :title, :release_date, :available_inventory, :total_inventory, :overview]),
    status: :ok
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
      
      render json: video.as_json(only: [:id, :title, :release_date, :available_inventory, :total_inventory, :overview])
      
    end
    
    def create 
      video = Video.new(video_params)
      
      if video.save
        render json: video.as_json(only: [:id]), status: :created
        return
      else
        render json: {
          ok: false,
          message: 'Did not create video'
          }, status: :bad_request
          return   
        end
      end 
      
      # TODO: add this in the else block, 
      # update tests with: body = JSON.parse(response.body)
      # expect(body["errors"].keys).must_include "age"
      # render json: {
      #   ok: false,
      #   errors: video.errors.messages
      #   }, status: :bad_request
      
      private
      
      def video_params
        return params.require(:video).permit(:title, :release_date, :available_inventory, :total_inventory, :overview)
      end
      
      
    end
    