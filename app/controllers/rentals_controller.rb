class RentalsController < ApplicationController

  def check_in

    new_rental = Rental.find_by(id: params[:id])
    
    if new_rental.nil?
      render json: {ok: false, errors: "Not found"}, status: :not_found
      return
    end

    new_rental.check_in = Time.now
    new_rental.movie.available_inventory += 1

    if new_rental.save && new_rental.movie.save
      render json: new_rental.as_json(only: [:check_in]), status: :ok 
      return
    else 
      render json: {ok: false, errors: new_rental.errors.messages}, status: :bad_request
      return
    end 
  end
  

  def check_out
    rental = Rental.new(rental_params)
    rental.setup_dates
    
    if rental.valid?
      if rental.movie.check_inventory
        if rental.save
          rental.movie.decrease_inventory
          rental.customer.increase_movies_checkout
          render json: rental.as_json(only: [:customer_id, :movie_id]), status: :ok
          return
        else
          render json: { ok: false, errors: "Error." }, status: :bad_request
          return
        end
      else
        render json: { ok: false, errors: "Video not found." }, status: :bad_request
      end
    else
      render json: { ok: false, errors: rental.errors.messages }, status: :bad_request
    end

  end


  private
  def rental_params
    params.permit(:customer_id, :movie_id, :checkout, :check_in, :check_out, :due_date)
  end
end
