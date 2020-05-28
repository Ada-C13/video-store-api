class RentalsController < ApplicationController
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

  def check_in
    # customer = Customer.find_by(id: rental_params[:customer_id])
    # video = Video.find_by(id: rental_params[:video_id])
    rental = Rental.where(customer_id: rental_params[:customer_id], video_id: rental_params[:video_id]).first

    if rental.nil?
      render json: { errors: ["Not Found"] }, status: :not_found
    else
      rental.customer.videos_checked_out_count = rental.customer.videos_checked_out_count - 1
      rental.video.available_inventory = rental.video.available_inventory + 1

      # if count > 0
      # customer.videos_checked_out_count = count - 1
      # end
      # video.available_inventory = avail + 1
      # customer.save
      # video.save

      # if customer.save && video.save
        check_in_hash = { "customer_id": rental.customer.id,
          "video_id": rental.video.id,
          "videos_checked_out_count": rental.customer.videos_checked_out_count,
          "available_inventory": rental.video.available_inventory }

        render json: check_in_hash.as_json, status: :ok
        return
      # else
      #   render json: { error: "Unable to update database" }, status: :internal_server_error
      #   return
      # end
    end
  end


  private 

  def rental_params
    return params.permit(:customer_id, :video_id)
  end 
end


# video_id: rental.video_id, due_date: rental.due_date, videos_checked_out_count: rental.customer.videos_checked_out_count, available_inventory: rental.video.available_inventory