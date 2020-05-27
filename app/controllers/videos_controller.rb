class VideosController < ApplicationController
  before_action :set_video, only: [:show]

  # GET /videos
  def index
    @videos = Video.all.as_json(only: [:id, :title, :release_date, :available_inventory])
    render json: @videos, status: :ok
  end


  # GET /videos/1
  def show
    render json: @video
  end

  # POST /videos
  def create
    @video = Video.new(video_params)

    if @video.save
      render json: @video, status: :created, location: @video
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def video_params
      params.fetch(:video, {})
    end
end
