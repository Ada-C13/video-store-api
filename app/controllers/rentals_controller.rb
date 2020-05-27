class RentalsController < ApplicationController
  def check_in
  end

  def check_out
    due_date = DateTime.now + 7 
    rental = Rental.new(rental_params)
    rental.due_date = due_date

    if rental.save 

      rental.customer.videos_checked_out_count = rental.customer.videos_checked_out_count + 1 
      rental.video.available_inventory = rental.video.available_inventory - 1 
     
      checkout = {
        "customer_id": rental.customer_id,
        "video_id": rental.video_id,
        "due_date": rental.due_date,
        "videos_checked_out_count": rental.customer.videos_checked_out_count,
        "available_inventory": rental.video.available_inventory
      } 

      render json: checkout.as_json,  status: :ok

    else
      render json:{ errors: ["Not Found"]}  , status: :not_found
    end 

  end

  private 

  def rental_params
    return params.permit(:customer_id, :video_id, :due_date)
  end 

end


# video_id: rental.video_id, due_date: rental.due_date, videos_checked_out_count: rental.customer.videos_checked_out_count, available_inventory: rental.video.available_inventory