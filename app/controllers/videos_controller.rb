class VideosController < ApplicationController
  before_action :set_video, only: [:show]

  # GET /videos
  def index
    # TO-DO: available inventory
    @videos = Video.all.as_json(only: [:id, :title, :release_date])
    render json: @videos
  end

  # GET /videos/1
  def show
    if @video
      @video = @video.as_json(only: [:title, :overview, :release_date, :total_inventory])
      render json: @video, status: :ok
    else 
      render json: { errors: ["Not Found"]}, status: :not_found
    end

  end

  # POST /videos
  def create
    @video = Video.new(video_params)

    if @video.save
      render json: {id: @video.id}, status: :created, location: @video
    else
      render json: {errors: @video.errors }, status: :bad_request
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find_by(id: params[:id])
      # @video = Video.find(params[:id])  

      # rescue ActiveRecord::RecordNotFound => e
      #   render json: {
      #     error: e.to_s
      #   }, status: :not_found
    
    end

    # Only allow a trusted parameter "white list" through.
    def video_params
      # params.fetch(:video, {})
      return params.permit(:title, :overview, :release_date, :total_inventory)
    end
end