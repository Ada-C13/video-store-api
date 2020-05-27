class VideosController < ApplicationController
    def index 
        # videos = Videos.all
        render json: {message: "it works!"}, status: :ok
    end
end
