class RentalsController < ApplicationController

  def check_out
    rental = Rental.check_out(@customer, @movie)
    if rental 
      render json: rental.as_json(only: [:id]), status: :ok
      return
    else
      render json: { ok: false, errors: "Not Found"}, status: :not_found
      return
    end
  end

  def check_in
    rental = Rental.check_in(@rental)
    if rental
      render json: rental.as_json(only: [:id]), status: :ok
      return
    else
      render json: { ok: false, errors: "Not Found"}, status: :not_found
      return
    end
  end

  private
  def rental_params
    params.permit(:video_id, :customer_id)
  end

end
