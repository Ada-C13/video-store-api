class RentalsController < ApplicationController
  def check_in
    customer_id = rental_params[:customer_id]
    video_id = rental_params[:video_id]


    if customer_id.nil? || video_id.nil?
      render json: { error: "Not Found" }, status: :not_found
    else
      customer = Customer.find_by(id: customer_id)
      video = Video.find_by(id: video_id)

      customer.videos_checked_out_count = customer.videos_checked_out_count - 1
      video.available_inventory = video.available_inventory + 1
      
      if customer.save! && video.save!
        check_in_hash = { "customer_id": customer_id,
          "video_id": video_id,
          "videos_checked_out_count": customer.videos_checked_out_count,
          "available_inventory": video.available_inventory }
        render json: check_in_hash.as_json, status: :ok
      else
        render json: { error: "Unable to update database" }, status: :internal_server_error
      end
    end
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