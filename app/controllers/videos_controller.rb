class VideosController < ApplicationController
  before_action :set_video, only: [:show]

  # GET /videos
  def index
    @videos = Video.all.as_json(only: [:id, :title, :release_date, :available_inventory])
    render json: @videos
  end

  # GET /videos/1
  def show
    @video = @video.as_json(only: [:title, :overview, :release_date, :total_inventory, :available_inventory])
    render json: @video, status: :ok
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
      @video = Video.find(params[:id])      
    end

    # Only allow a trusted parameter "white list" through.
    def video_params
      # params.fetch(:video, {})
      return params.permit(:title, :overview, :release_date, :total_inventory, :available_inventory)
    end
end
