class RentalsController < ApplicationController

  def check_in
    rental = Rental.find_by(id: params[:id])
    if rental.nil?
      render json: {ok: false, errors: "Not found"}, status: :not_found
      return
    end
    if rental.save
      rental.set_check_in_date
      rental.video.available_inventory += 1
      render json: rental.as_json(only: [:customer_id, :video_id]), status: :ok 
      return
    else 
      render json: {ok: false, errors: rental.errors.messages}, status: :bad_request
      return
    end 
  end
  

  def check_out
    rental = Rental.new(rental_params)
    if rental.valid?
      if rental.video.available_inventory > 0
        rental.video.available_inventory -= 1
        rental.check_out
        rental.save
        render json: rental.as_json(only: 
          [:customer_id, :video_id, :due_date, :videos_checked_out_count, :available_inventory
          ]), status: :created
        return
      else
        render json: { ok: false, errors: "Video not available." }, status: :bad_request
        return
      end
    else
      render json: { ok: false, errors: rental.errors.messages }, status: :bad_request
      return
    end

  end


  private
  def rental_params
    params.permit(:customer_id, :video_id)
  end
end
