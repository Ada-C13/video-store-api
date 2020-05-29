class ApplicationController < ActionController::API

  def zomg
    render json: {message: "it runs!"}, status: :ok
  end
end
