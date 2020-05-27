class VideosController < ApplicationController

  def index

    videos = Video.all.as_json(only: [:id, :title, :overview, :release_date, :total_inventory, :available_inventory])
    render json: videos, status: :ok
        
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

    if video
      render json: video.as_json(only: [:id, :title, :overview, :release_date, :total_inventory, :available_inventory])
      return
    else
      render json: { ok: false, errors: ["Not Found"] }, status: :not_found
      return
    end
  end

  # GET /videos/new
  def new
    @video = Video.new
  end
  
  def destroy
    @work.destroy
    flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
    redirect_to root_path
      
  end
  
  
  private

  def video_params
    return params.require(:video).permit(:title, :overview, :release_date, :total_inventory, :available_inventory)
  end

end
