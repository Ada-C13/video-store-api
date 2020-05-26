class VideosController < ApplicationController
	def index
		videos = Video.all.as_json(only: [:title, :overview, :release_date, :total_inventory, :available_inventory])
		render json: videos, status: :ok
	end
end
