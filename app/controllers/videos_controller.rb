class VideosController < ApplicationController
  before_action :set_video, only: [:show]

  # GET /videos
  def index
    # TO-DO: available inventory
    @videos = Video.order(:title)

    render json: @videos.to_json(
      :only => [:id, :title, :release_date], :methods => [:available_inventory]), status: :ok
  end

  # GET /videos/1
  def show
    if @video
    render json: @video.to_json(
      :only => [:title, :overview, :release_date, :total_inventory], :methods => [:available_inventory]), status: :ok
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
      #     error: e
      #   }, status: :not_found
    
    end

    # Only allow a trusted parameter "white list" through.
    def video_params
      # params.fetch(:video, {})
      return params.permit(:title, :overview, :release_date, :total_inventory)
    end
end